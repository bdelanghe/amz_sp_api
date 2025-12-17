git_blob_sha() {
  local file="$1"

  # We want the content-hash of the JSON *as stored in the snapshot checkout*.
  # `git hash-object` reads from the filesystem, but paths must be correct relative
  # to the repo we run it in.
  #
  # MODELS_DIR points at:  <snapshot_root>/models
  # so snapshot_root is:   <snapshot_root>
  #
  # `find` yields paths that may be relative (e.g. .models/df0f6a4/models/...) or
  # absolute. Normalize both to absolute, then derive a snapshot-root-relative path.

  local snapshot_root_abs file_abs rel

  snapshot_root_abs="$(cd "$MODELS_DIR/.." && pwd -P)"

  # Normalize file to an absolute path (works for both relative and absolute inputs).
  file_abs="$(cd "$snapshot_root_abs" && perl -MCwd=abs_path -e 'print abs_path(shift)' "$file")"

  # Derive repo-relative path for hash-object.
  rel="${file_abs#"$snapshot_root_abs/"}"

  (cd "$snapshot_root_abs" && git hash-object "$rel")
}
#!/usr/bin/env bash
set -euo pipefail

# plan.sh
# Build a deterministic plan from a *local snapshot checkout* of
# amzn/selling-partner-api-models, selecting the most recent spec per API dir.
#
# Inputs:
#   - MODELS_DIR (optional): path to the `models/` directory inside the snapshot
#   - lib/.codegen_models_sha (required unless MODELS_DIR is set)
#
# Outputs:
#   - .codegen-logs/.plan.tsv
#   - lib/.codegen_plan.tsv

CODEGEN_SHA_FILE="lib/.codegen_models_sha"

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

# Derive a YYYY-MM-DD date from a filename like:
#   foo_2024-03-20.json, foo-2024-03-20.json, foo2024-03-20.json
# Returns empty string if no date is present.
extract_date() {
  local name="$1"
  if [[ "$name" =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
    echo "${BASH_REMATCH[1]}"
  else
    echo ""
  fi
}

# Extract suffix like V0 / V1 from a filename ending in V#.json
# Returns empty string if no V-suffix.
extract_vsuffix() {
  local name="$1"
  if [[ "$name" =~ (V[0-9]+)\.json$ ]]; then
    echo "${BASH_REMATCH[1]}"
  else
    echo ""
  fi
}

# Compute the blob SHA for a file as stored in the snapshot's git repo.
# Prefers `HEAD:path` (true git blob), falls back to hashing the file contents.
git_blob_sha() {
  local snapshot_root_abs="$1"   # absolute path to snapshot repo root
  local file_abs="$2"            # absolute path to file on disk

  [[ -n "$snapshot_root_abs" ]] || fail "git_blob_sha: missing snapshot_root_abs"
  [[ -n "$file_abs" ]] || fail "git_blob_sha: missing file_abs"

  local rel="${file_abs#"$snapshot_root_abs/"}"
  if [[ "$rel" == "$file_abs" ]]; then
    fail "git_blob_sha: file is not under snapshot root: $file_abs"
  fi

  if git -C "$snapshot_root_abs" rev-parse --quiet --verify "HEAD:$rel" >/dev/null; then
    git -C "$snapshot_root_abs" rev-parse "HEAD:$rel"
  else
    # Fallback: hash the file content directly
    git -C "$snapshot_root_abs" hash-object -- "$rel"
  fi
}

# Choose the newest dated JSON among files in a directory.
# Prints the selected absolute path, or empty if none.
select_newest_dated_json() {
  local api_dir="$1"
  local best_date=""
  local best_path=""

  local f base date
  shopt -s nullglob
  for f in "$api_dir"/*.json; do
    base="$(basename "$f")"
    date="$(extract_date "$base")"
    [[ -n "$date" ]] || continue

    if [[ -z "$best_date" || "$date" > "$best_date" ]]; then
      best_date="$date"
      best_path="$f"
    fi
  done
  shopt -u nullglob

  echo "$best_path"
}

main() {
  # Resolve upstream SHA
  local upstream_sha="${UPSTREAM_SHA:-}"
  if [[ -z "$upstream_sha" ]]; then
    if [[ -f "$CODEGEN_SHA_FILE" ]]; then
      upstream_sha="$(cat "$CODEGEN_SHA_FILE")"
    fi
  fi
  [[ -n "$upstream_sha" ]] || fail "Missing UPSTREAM_SHA (env) and $CODEGEN_SHA_FILE"

  local upstream_short_sha="${upstream_sha:0:7}"
  local models_url="https://github.com/amzn/selling-partner-api-models/tree/${upstream_sha}/models"

  # Resolve MODELS_DIR
  local models_dir="${MODELS_DIR:-.models/${upstream_short_sha}/models}"
  [[ -d "$models_dir" ]] || fail "Models root not found: $models_dir"

  local snapshot_root_abs
  snapshot_root_abs="$(cd "$models_dir/.." && pwd -P)"

  mkdir -p .codegen-logs lib

  echo "Building codegen plan from models snapshot"
  echo "Models: ${models_url}"
  echo "SHA:    ${upstream_sha}"
  echo "Root:   ${models_dir}"
  echo

  local plan_tsv=".codegen-logs/.plan.tsv"
  local plan_copy="lib/.codegen_plan.tsv"

  # TSV columns:
  # api_name \t selected_version \t json_basename \t json_abs_path \t blob_sha
  : > "$plan_tsv"

  echo "Scanning API directories..."

  local api_dir api_name
  local -a display_lines=()

  shopt -s nullglob
  for api_dir in "$models_dir"/*; do
    [[ -d "$api_dir" ]] || continue

    api_name="$(basename "$api_dir")"
    echo "→ Inspecting ${api_name}"

    # Build a list of JSON files directly under this API directory.
    local -a jsons=("$api_dir"/*.json)
    if (( ${#jsons[@]} == 0 )); then
      echo "  skipping: no .json specs"
      continue
    fi

    # 1) Base API selection: newest dated JSON if any, else newest non-dated by name.
    local base_selected=""
    local base_version=""

    base_selected="$(select_newest_dated_json "$api_dir")"
    if [[ -n "$base_selected" ]]; then
      base_version="$(extract_date "$(basename "$base_selected")")"
    else
      # No dated specs. Choose a stable fallback:
      # - prefer a non-V* json with lexicographically last name (stable)
      local best=""
      local f b vs
      for f in "${jsons[@]}"; do
        b="$(basename "$f")"
        vs="$(extract_vsuffix "$b")"
        [[ -n "$vs" ]] && continue
        if [[ -z "$best" || "$b" > "$(basename "$best")" ]]; then
          best="$f"
        fi
      done
      if [[ -n "$best" ]]; then
        base_selected="$best"
        base_version="(undated)"
      fi
    fi

    if [[ -n "$base_selected" ]]; then
      local base_file base_blob
      base_file="$(basename "$base_selected")"
      base_blob="$(git_blob_sha "$snapshot_root_abs" "$(cd "$snapshot_root_abs" && python3 -c 'import os,sys; print(os.path.abspath(sys.argv[1]))' "$base_selected")")"

      printf "%s\t%s\t%s\t%s\t%s\n" \
        "$api_name" "$base_version" "$base_file" "$base_selected" "$base_blob" \
        >> "$plan_tsv"

      display_lines+=("  ${api_name} -> ${base_version} (${base_file}) [${base_blob}]")
      echo "  selected: ${api_name} (${base_file})"
      echo "  blob:     ${base_blob}"
    fi

    # 2) Also include V-suffix variants (V0/V1/etc) as separate plan entries.
    #    These are treated as older than dated specs, but still preserved.
    local f b vs
    for f in "${jsons[@]}"; do
      b="$(basename "$f")"
      vs="$(extract_vsuffix "$b")"
      [[ -n "$vs" ]] || continue

      local vs_api_name="${api_name}-${vs}"
      local vs_version="${vs}"

      local vs_blob
      vs_blob="$(git_blob_sha "$snapshot_root_abs" "$(cd "$snapshot_root_abs" && python3 -c 'import os,sys; print(os.path.abspath(sys.argv[1]))' "$f")")"

      printf "%s\t%s\t%s\t%s\t%s\n" \
        "$vs_api_name" "$vs_version" "$b" "$f" "$vs_blob" \
        >> "$plan_tsv"

      display_lines+=("  ${vs_api_name} -> ${vs_version} (${b}) [${vs_blob}]")
      echo "  selected: ${vs_api_name} (${b})"
      echo "  blob:     ${vs_blob}"
    done

  done
  shopt -u nullglob

  # Sort the display (most recent -> oldest), with undated/V* after dated.
  # We sort by a synthetic key:
  #   - dated: key = date
  #   - undated: key = 0000-00-00
  #   - V*: key = 0000-00-00
  echo
  echo "Plan: $(wc -l < "$plan_tsv" | tr -d ' ') API(s)"
  echo
  echo "API selections (most recent -> oldest):"

  # Convert display_lines to sortable records.
  # Format: key<TAB>line
  {
    for line in "${display_lines[@]}"; do
      # extract the version field between '->' and '(' and trim
      ver="${line#*-> }"
      ver="${ver%% (*}"
      ver="$(echo "$ver" | sed -e 's/[[:space:]]*$//')"
      if [[ "$ver" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        key="$ver"
      else
        key="0000-00-00"
      fi
      printf "%s\t%s\n" "$key" "$line"
    done
  } | sort -r | cut -f2-

  cp "$plan_tsv" "$plan_copy"

  echo
  echo "Plan written to: ${plan_tsv}"
  echo "Saved copy:      ${plan_copy}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  main "$@"
fi