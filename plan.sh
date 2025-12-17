#!/bin/bash
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

: "${MODELS_DIR:?MODELS_DIR must be set by env.sh}"
: "${UPSTREAM_SHA:?UPSTREAM_SHA must be set by env.sh}"
: "${MODELS_URL:?MODELS_URL must be set by env.sh}"

readonly CODEGEN_LOG_DIR=".codegen-logs"
readonly PLAN_TSV="${CODEGEN_LOG_DIR}/.plan.tsv"
readonly DUP_TSV="${CODEGEN_LOG_DIR}/duplicates.tsv"

readonly PLAN_SAVE_DIR="lib"
readonly PLAN_SAVE_TSV="${PLAN_SAVE_DIR}/.codegen_plan.tsv"
readonly PLAN_SAVE_DUP_TSV="${PLAN_SAVE_DIR}/.codegen_plan_duplicates.tsv"

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
  while IFS= read -r d; do
    d="${d//-/}"
    if [[ -z "$best" || "$d" > "$best" ]]; then
      best="$d"
    fi
  done < <(printf '%s' "$s" | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' || true)

  printf '%s' "$best"
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
  mapfile -t specs < <(find "$api_dir" -maxdepth 1 -type f -name '*.json' -print | sort)
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

  local cnt="${#specs[@]}"
  printf '%s\t%s\t%s\t%s\n' "$api" "$(api_module_name "$api")" "$selected" "$cnt" >> "$PLAN_TSV"

  if [[ -n "$v0_spec" ]]; then
    local api_v0="${api}-V0"
    printf '%s\t%s\t%s\t%s\n' "$api_v0" "$(api_module_name "$api_v0")" "$v0_spec" "$cnt" >> "$PLAN_TSV"
  fi
}

write_duplicates_row() {
  local api="$1"; shift
  local -a specs=("$@")

  if [[ ${#specs[@]} -le 1 ]]; then
    return 0
  fi

  local cands
  cands="$(
    for s in "${specs[@]}"; do
      basename "$s"
    done | paste -sd, -
  )"

  printf '%s\t%s\t%s\n' "$api" "${#specs[@]}" "$cands" >> "$DUP_TSV"
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
  echo "API selections (api_name -> spec):"

  # Pretty, deterministic display from the plan itself.
  while IFS=$'\t' read -r api mod spec cnt; do
    # Print the basename only; keep output compact.
    printf '  %-40s -> %-32s (candidates: %s)\n' "$api" "$(basename "$spec")" "$cnt"
  done < "$PLAN_TSV"

  if [[ -s "$DUP_TSV" ]]; then
    local dup_count
    dup_count="$(wc -l < "$DUP_TSV" | tr -d ' ')"
    echo ""
    echo "Duplicates: ${dup_count} API folder(s) have multiple specs."
    echo "  See: ${DUP_TSV}"
  fi

  echo ""
  echo "Plan written to: ${PLAN_TSV}"
  echo "Saved copy:      ${PLAN_SAVE_TSV}"
  echo "Saved dups copy: ${PLAN_SAVE_DUP_TSV}"
}

main() {
  mkdir -p "$CODEGEN_LOG_DIR"
  : > "$PLAN_TSV"
  : > "$DUP_TSV"

  # The models snapshot layout is: <MODELS_DIR>/<api-folder>/*.json
  # So build the plan by enumerating folders, not by a global find.
  local -a api_dirs
  mapfile -t api_dirs < <(find "$MODELS_DIR" -mindepth 1 -maxdepth 1 -type d -print | sort)

  local dir api
  for dir in "${api_dirs[@]}"; do
    api="$(basename "$dir")"

    # Special-case fulfillment inbound to emit v1 + v0 as separate APIs.
    if [[ "$api" == "fulfillment-inbound-api-model" ]]; then
      local -a specs
      mapfile -t specs < <(find "$dir" -maxdepth 1 -type f -name '*.json' -print | sort)
      write_duplicates_row "$api" "${specs[@]}"
      emit_fulfillment_inbound_plan "$dir"
      continue
    fi

    local -a specs
    mapfile -t specs < <(find "$dir" -maxdepth 1 -type f -name '*.json' -print | sort)
    if [[ ${#specs[@]} -eq 0 ]]; then
      continue
    fi

    write_duplicates_row "$api" "${specs[@]}"

    local selected
    selected="$(select_spec_for_api "$api" "${specs[@]}")"

    local cnt="${#specs[@]}"
    printf '%s\t%s\t%s\t%s\n' "$api" "$(api_module_name "$api")" "$selected" "$cnt" >> "$PLAN_TSV"
  done

  # Fulfillment inbound should appear at the end (and its -V0 variant after it).
  # The loop above inserts it in-place; re-sort while keeping stable fulfillment ordering.
  # We do this by splitting and concatenating.
  local tmp_all tmp_main tmp_fi
  tmp_all="${CODEGEN_LOG_DIR}/.plan.tmp.all.tsv"
  tmp_main="${CODEGEN_LOG_DIR}/.plan.tmp.main.tsv"
  tmp_fi="${CODEGEN_LOG_DIR}/.plan.tmp.fi.tsv"

  cp "$PLAN_TSV" "$tmp_all"

  grep -v '^fulfillment-inbound-api-model\t' "$tmp_all" | grep -v '^fulfillment-inbound-api-model-V0\t' "$tmp_all" | sort > "$tmp_main" || true
  {
    cat "$tmp_main"
    grep '^fulfillment-inbound-api-model\t' "$tmp_all" || true
    grep '^fulfillment-inbound-api-model-V0\t' "$tmp_all" || true
  } > "$PLAN_TSV"

  rm -f "$tmp_all" "$tmp_main" "$tmp_fi" 2>/dev/null || true

  print_plan_summary

  # Persist the plan artifacts under lib/ so they can be inspected without digging into .codegen-logs.
  mkdir -p "$PLAN_SAVE_DIR"
  cp "$PLAN_TSV" "$PLAN_SAVE_TSV"
  cp "$DUP_TSV" "$PLAN_SAVE_DUP_TSV"
}

main "$@"