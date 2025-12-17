#!/bin/sh
# plan.sh is written for bash (uses process substitution, [[ ]], arrays).
# If invoked via /bin/sh (or the shebang is honored), re-exec under bash.
#
# Use BASH_VERSINFO (a bash-only array) instead of BASH_VERSION, because
# BASH_VERSION can be exported and would trick /bin/sh into thinking it's bash.
if [ -z "${BASH_VERSINFO+set}" ]; then
  exec /usr/bin/env bash "$0" "$@"
fi
set -euo pipefail

# plan.sh
# Build a deterministic codegen plan from a pinned selling-partner-api-models snapshot.
# Reads contract inputs from ./env.sh and writes plan artifacts under .codegen-logs/.

if [[ ! -f "./env.sh" ]]; then
  echo "Missing ./env.sh. Run from repo root." >&2
  exit 1
fi
# shellcheck disable=SC1091
source "./env.sh"

echo "Building codegen plan from models snapshot"
echo "Models: ${MODELS_URL}"
echo "SHA:    ${UPSTREAM_SHA}"
echo "Root:   ${MODELS_DIR}"
echo ""

: "${MODELS_DIR:?MODELS_DIR must be set by env.sh}"
: "${UPSTREAM_SHA:?UPSTREAM_SHA must be set by env.sh}"
: "${MODELS_URL:?MODELS_URL must be set by env.sh}"

readonly CODEGEN_LOG_DIR=".codegen-logs"
readonly PLAN_TSV="${CODEGEN_LOG_DIR}/.plan.tsv"

readonly PLAN_SAVE_DIR="lib"
readonly PLAN_SAVE_TSV="${PLAN_SAVE_DIR}/.codegen_plan.tsv"

# Compute the git blob SHA for a file inside the models snapshot.
# Assumes MODELS_DIR is a git worktree or checkout.
git_blob_sha() {
  local file="$1"
  (cd "$MODELS_DIR/.." && git hash-object "$file")
}

# Convert kebab-case API name into a Ruby ModuleName.
# Example: "fulfillment-outbound-api-model" -> "FulfillmentOutboundApiModel"
api_module_name() {
  local api_name="$1"
  echo "$api_name" | perl -pe 's/(^|-)./uc($&)/ge;s/-//g'
}

# Extract the highest YYYY-MM-DD found in a filename, as YYYYMMDD.
# Returns "" if no date exists.
max_date_score() {
  local s="$1"
  local best=""
  local d

  # Pull all YYYY-MM-DD substrings (if any), then keep the max.
  local tmp_dates
  tmp_dates="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm -f '$tmp_dates'" RETURN

  printf '%s' "$s" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' >"$tmp_dates" 2>/dev/null || true
  while IFS= read -r d; do
    d="${d//-/}"
    if [[ -z "$best" || "$d" > "$best" ]]; then
      best="$d"
    fi
  done <"$tmp_dates"

  rm -f "$tmp_dates"
  trap - RETURN

  printf '%s' "$best"
}

# Compute a human suffix for a spec file (no extension).
# Examples:
#   awd_2024-05-09.json                -> 2024-05-09
#   appIntegrations-2024-04-01.json    -> 2024-04-01
#   fulfillmentInboundV0.json          -> V0
#   vendorOrders.json                 -> vendorOrders
spec_suffix() {
  local base
  base="$(basename "$1" .json)"

  if [[ "$base" =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
    printf '%s' "${BASH_REMATCH[1]}"
    return 0
  fi

  if [[ "$base" =~ (V[0-9]+)$ ]]; then
    printf '%s' "${BASH_REMATCH[1]}"
    return 0
  fi

  printf '%s' "$base"
}

# Sort score for ordering plans: YYYYMMDD (numeric-ish string). No date => 00000000.
spec_sort_score() {
  local d
  d="$(max_date_score "$(basename "$1")")"
  if [[ -n "$d" ]]; then
    printf '%s' "$d"
  else
    printf '%s' "00000000"
  fi
}

# Choose exactly one spec for an API folder.
# General preference:
#   1) highest dated spec in filename (if any exist)
#   2) otherwise, a *V0.json (common upstream pattern)
#   3) otherwise, last filename in sort order
select_spec_for_api() {
  local api="$1"; shift
  local -a specs=("$@")

  local best_spec=""
  local best_date=""

  # 1) Prefer highest dated spec (if any)
  local spec date
  for spec in "${specs[@]}"; do
    date="$(max_date_score "$(basename "$spec")")"
    if [[ -n "$date" ]]; then
      if [[ -z "$best_date" || "$date" > "$best_date" ]]; then
        best_date="$date"
        best_spec="$spec"
      elif [[ "$date" == "$best_date" ]]; then
        # tie-break: later basename wins
        if [[ "$(basename "$spec")" > "$(basename "$best_spec")" ]]; then
          best_spec="$spec"
        fi
      fi
    fi
  done
  if [[ -n "$best_spec" ]]; then
    printf '%s' "$best_spec"
    return 0
  fi

  # 2) No dated specs.
  # Prefer a non-versioned filename over V0/V1 variants when both exist.
  # (V0/V1 are typically older / legacy and should not win by accident.)
  local -a non_versioned
  for spec in "${specs[@]}"; do
    if [[ ! "$(basename "$spec")" =~ V[0-9]+\.json$ ]]; then
      non_versioned+=("$spec")
    fi
  done

  if [[ ${#non_versioned[@]} -gt 0 ]]; then
    printf '%s\n' "${non_versioned[@]}" | sort | tail -n 1
    return 0
  fi

  # 3) Only versioned filenames exist (e.g. just V0/V1); take the last lexicographically.
  printf '%s\n' "${specs[@]}" | sort | tail -n 1
}

# Special-case fulfillment inbound:
# - Always emit two plan entries if V0 exists:
#     fulfillment-inbound-api-model      -> newest dated spec (NOT V0)
#     fulfillment-inbound-api-model-V0   -> fulfillmentInboundV0.json
# - If no dated spec exists, fall back to non-V0 selection rules.
emit_fulfillment_inbound_plan() {
  local api_dir="$1" # .../models/fulfillment-inbound-api-model

  local api="fulfillment-inbound-api-model"
  local -a specs
  local tmp_specs
  tmp_specs="$(mktemp)"
  find "$api_dir" -maxdepth 1 -type f -name '*.json' -print | sort >"$tmp_specs"
  while IFS= read -r s; do
    [[ -n "$s" ]] && specs+=("$s")
  done <"$tmp_specs"
  rm -f "$tmp_specs"
  if [[ ${#specs[@]} -eq 0 ]]; then
    return 0
  fi

  local v0_spec=""
  local -a non_v0
  local s
  for s in "${specs[@]}"; do
    if [[ "$s" == *V0.json ]]; then
      v0_spec="$s"
    else
      non_v0+=("$s")
    fi
  done

  local selected=""
  if [[ ${#non_v0[@]} -gt 0 ]]; then
    selected="$(select_spec_for_api "$api" "${non_v0[@]}")"
  else
    selected="$(select_spec_for_api "$api" "${specs[@]}")"
  fi

  echo "  selected: ${api} ($(basename "$selected"))"
  local cnt="${#specs[@]}"
  local blob
  blob="$(git_blob_sha "$selected")"
  printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$api" "$(api_module_name "$api")" "$selected" "$cnt" "$(spec_suffix "$selected")" "$blob" >> "$PLAN_TSV"

  if [[ -n "$v0_spec" ]]; then
    local api_v0="${api}-V0"
    echo "  selected: ${api}-V0 ($(basename "$v0_spec"))"
    local blob_v0
    blob_v0="$(git_blob_sha "$v0_spec")"
    printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$api_v0" "$(api_module_name "$api_v0")" "$v0_spec" "$cnt" "$(spec_suffix "$v0_spec")" "$blob_v0" >> "$PLAN_TSV"
  fi
}

print_plan_summary() {
  local api_count
  api_count="$(wc -l < "$PLAN_TSV" | tr -d ' ')"

  echo "Models: ${MODELS_URL}"
  echo "SHA:    ${UPSTREAM_SHA}"
  echo "Root:   ${MODELS_DIR}"
  echo ""
  echo "Plan: ${api_count} API(s)"
  echo ""
  echo "API selections (most recent -> oldest):"

  # plan columns: api, module, spec_path, candidate_count, suffix, blob_sha
  while IFS=$'\t' read -r api mod spec cnt suffix blob; do
    printf '  %-35s -> %-15s (%s @ %s)\n' "$api" "$suffix" "$(basename "$spec")" "$blob"
  done < "$PLAN_TSV"

  echo ""
  echo "Plan written to: ${PLAN_TSV}"
  echo "Saved copy:      ${PLAN_SAVE_TSV}"
}

main() {
  mkdir -p "$CODEGEN_LOG_DIR"
  : > "$PLAN_TSV"
  echo "Scanning API directories..."

  # The models snapshot layout is: <MODELS_DIR>/<api-folder>/*.json
  # So build the plan by enumerating folders, not by a global find.
  local -a api_dirs
  local tmp_dirs
  tmp_dirs="$(mktemp)"
  find "$MODELS_DIR" -mindepth 1 -maxdepth 1 -type d -print | sort >"$tmp_dirs"
  while IFS= read -r d; do
    [[ -n "$d" ]] && api_dirs+=("$d")
  done <"$tmp_dirs"
  rm -f "$tmp_dirs"

  local dir api
  for dir in "${api_dirs[@]}"; do
    api="$(basename "$dir")"
    echo "→ Inspecting ${api}"

    # Special-case fulfillment inbound to emit v1 + v0 as separate APIs.
    if [[ "$api" == "fulfillment-inbound-api-model" ]]; then
      local -a specs
      local tmp_specs
      tmp_specs="$(mktemp)"
      find "$dir" -maxdepth 1 -type f -name '*.json' -print | sort >"$tmp_specs"
      while IFS= read -r s; do
        [[ -n "$s" ]] && specs+=("$s")
      done <"$tmp_specs"
      rm -f "$tmp_specs"
      emit_fulfillment_inbound_plan "$dir"
      continue
    fi

    local -a specs
    local tmp_specs
    tmp_specs="$(mktemp)"
    find "$dir" -maxdepth 1 -type f -name '*.json' -print | sort >"$tmp_specs"
    while IFS= read -r s; do
      [[ -n "$s" ]] && specs+=("$s")
    done <"$tmp_specs"
    rm -f "$tmp_specs"
    if [[ ${#specs[@]} -eq 0 ]]; then
      continue
    fi

    local selected
    selected="$(select_spec_for_api "$api" "${specs[@]}")"
    echo "  selected: ${api} ($(basename "$selected"))"

    local cnt="${#specs[@]}"
    local blob
    blob="$(git_blob_sha "$selected")"
    printf '%s\t%s\t%s\t%s\t%s\t%s\n' "$api" "$(api_module_name "$api")" "$selected" "$cnt" "$(spec_suffix "$selected")" "$blob" >> "$PLAN_TSV"
  done

  echo ""
  echo "Ordering plan (most recent → oldest)…"
  # Order plan by most-recent -> oldest using the selected spec date (YYYYMMDD).
  # Keep fulfillment inbound entries at the very end (and -V0 last).
  local tmp_all tmp_main
  tmp_all="${CODEGEN_LOG_DIR}/.plan.tmp.all.tsv"
  tmp_main="${CODEGEN_LOG_DIR}/.plan.tmp.main.tsv"

  cp "$PLAN_TSV" "$tmp_all"

  # Sort everything except fulfillment-inbound by spec date descending.
  # Columns: api \t module \t spec_path \t cnt \t suffix \t blob
  grep -v '^fulfillment-inbound-api-model\t' "$tmp_all" | grep -v '^fulfillment-inbound-api-model-V0\t' "$tmp_all" \
    | awk -F'\t' '{ print $0 "\t" $3 }' \
    | while IFS=$'\t' read -r api mod spec cnt suffix blob spec_path; do
        score="$(spec_sort_score "$spec_path")"
        printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' "$score" "$api" "$mod" "$spec" "$cnt" "$suffix" "$blob"
      done \
    | sort -r -t $'\t' -k1,1 -k2,2 \
    | cut -f2- > "$tmp_main" || true

  {
    cat "$tmp_main"
    grep '^fulfillment-inbound-api-model\t' "$tmp_all" || true
    grep '^fulfillment-inbound-api-model-V0\t' "$tmp_all" || true
  } > "$PLAN_TSV"

  rm -f "$tmp_all" "$tmp_main" 2>/dev/null || true

  echo ""
  echo "Plan complete."
  echo ""

  print_plan_summary

  # Persist the plan artifacts under lib/ so they can be inspected without digging into .codegen-logs.
  mkdir -p "$PLAN_SAVE_DIR"
  cp "$PLAN_TSV" "$PLAN_SAVE_TSV"
}

main "$@"