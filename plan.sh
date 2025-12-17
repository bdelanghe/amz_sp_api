source ./env.sh

RED="\033[31m"
GREEN="\033[32m"
GREY="\033[90m"
RESET="\033[0m"
YELLOW="\033[33m"

# Print with ANSI escapes enabled (portable-ish across macOS bash).
# Use this instead of `echo -e`.
printb() {
  printf "%b\n" "$1"
}

# Emit a line to the plan file, optionally with semicolon-delimited flags.
# Format:
#   <model>/<prefix>@<version>#<sha>[; flag1, flag2]
# Flags are hints for downstream codegen behavior (including whether a leaf is being skipped).
emit_plan_line() {
  local model="$1" prefix="$2" version="$3" sha="$4" status="${5:-emit}" deprecated_flag="${6:-}"
  local -a flags=()

  # Emit explicit skip reasons instead of a generic "skipped".
  # - Deprecated leaves => skip_deprecated
  # - Non-best / legacy leaves => skip_legacy
  if [[ "$deprecated_flag" == "deprecated" ]]; then
    flags+=("skip_deprecated")
  elif [[ "$status" == "skip" ]]; then
    flags+=("skip_legacy")
  fi

  # If this model contains multiple prefixes, downstream generators must namespace
  # outputs by prefix to avoid collisions (e.g. finances vs transfers).
  if needs_prefix_namespace "$model"; then
    flags+=("use_prefix_namespace")
  fi

  # If this leaf was explicitly marked as supported legacy, preserve that intent.
  if is_supported_legacy "${model}|${prefix}|${version}"; then
    flags+=("supported_legacy")

    # Supported legacy versions are often V0/V1 style; downstream generators
    # frequently need help preserving that version as part of the namespace.
    if [[ "$version" =~ ^V[0-9]+$ ]]; then
      flags+=("use_version_namespace")
    fi
  fi

  if [[ ${#flags[@]} -gt 0 ]]; then
    (IFS=", "; echo "${model}/${prefix}@${version}#${sha}; ${flags[*]}" >> "$PLAN_OUT")
  else
    echo "${model}/${prefix}@${version}#${sha}" >> "$PLAN_OUT"
  fi
}

# Optional: mark specific non-best versions as "supported legacy".
# Usage (repeatable):
#   ./plan.sh --support-legacy <model>/<prefix>@<version>
# Example:
#   ./plan.sh --support-legacy fulfillment-inbound-api-model/fulfillmentInbound@V0
SUPPORTED_LEGACY_KEYS=""

add_supported_legacy() {
  local spec="$1"
  local m p v

  # Expect: model/prefix@version
  m="${spec%%/*}"
  p="${spec#*/}"; p="${p%@*}"
  v="${spec##*@}"

  if [[ -z "$m" || -z "$p" || -z "$v" || "$spec" != */*@* ]]; then
    echo "Invalid --support-legacy value: '$spec'" >&2
    echo "Expected: <model>/<prefix>@<version> (e.g. fulfillment-inbound-api-model/fulfillmentInbound@V0)" >&2
    exit 1
  fi

  SUPPORTED_LEGACY_KEYS+="${m}|${p}|${v}"$'\n'
}

is_supported_legacy() {
  local key="$1"
  # Exact, whole-line match.
  printf '%s' "$SUPPORTED_LEGACY_KEYS" | grep -Fxq "$key"
}

# If a model directory contains >1 distinct prefix namespace, downstream generators
# must treat the prefix as part of the output namespace to avoid collisions.
PREFIX_NAMESPACE_MODELS=""

add_prefix_namespace_model() {
  local model="$1"
  PREFIX_NAMESPACE_MODELS+="${model}"$'\n'
}

needs_prefix_namespace() {
  local model="$1"
  # Exact, whole-line match.
  printf '%s' "$PREFIX_NAMESPACE_MODELS" | grep -Fxq "$model"
}

# New store for version namespace keys (model|prefix)
VERSION_NAMESPACE_KEYS=""

add_version_namespace_key() {
  local key="$1"
  VERSION_NAMESPACE_KEYS+="${key}"$'\n'
}

needs_version_namespace() {
  local key="$1"
  # Exact, whole-line match.
  printf '%s' "$VERSION_NAMESPACE_KEYS" | grep -Fxq "$key"
}

# Parse args (keep it simple; ignore unknown flags for now)
while [[ $# -gt 0 ]]; do
  case "$1" in
    --support-legacy)
      shift
      [[ $# -gt 0 ]] || { echo "Missing value for --support-legacy" >&2; exit 1; }
      add_supported_legacy "$1"
      shift
      ;;
    *)
      # Ignore unknown args for forward-compat.
      shift
      ;;
  esac
done

PLAN_OUT=".codegen-plan"
: > "$PLAN_OUT"

MODEL_DIRS=$(find "$MODELS_DIR" -mindepth 1 -maxdepth 1 -type d | sort)

echo "Listing files inside each model directory:"

# Iterate models in a stable order
for model_dir in $MODEL_DIRS; do
  model="$(basename "$model_dir")"

  tmp="$(mktemp)"

  # Collect (prefix, version, deprecated, blob_sha) tuples for this model.
  find "$model_dir" -type f | sort | while read -r file; do
    fname="$(basename "$file")"
    ext="${fname##*.}"
    name="${fname%.*}"

    prefix="$name"
    version=""

    # Date-like version suffix: _YYYY-MM-DD, -YYYY-MM-DD, VYYYY-MM-DD
    if [[ "$name" =~ ([_-]?V?[0-9]{4}-[0-9]{2}-[0-9]{2})$ ]]; then
      raw_suffix="${BASH_REMATCH[1]}"
      prefix="${name%$raw_suffix}"
      version="${raw_suffix#[_-]}"

    # Numeric version suffix: V0, V1, ...
    elif [[ "$name" =~ (V[0-9]+)$ ]]; then
      raw_suffix="${BASH_REMATCH[1]}"
      prefix="${name%$raw_suffix}"
      version="${raw_suffix#[_-]}"
    fi

    deprecated=""
    if [[ "$ext" == "md" ]]; then
      if grep -qi "this api has been removed" "$file"; then
        deprecated="DEPRECATED"
      fi
    fi

    blob_sha="$(git hash-object "$file" 2>/dev/null | cut -c1-7)"

    printf '%s\t%s\t%s\t%s\n' "$prefix" "$version" "$deprecated" "$blob_sha" >> "$tmp"
  done

  # Detect if this model has >1 distinct prefix; if so, require prefix namespacing.
  prefix_count="$(cut -f1 "$tmp" | sort -u | wc -l | tr -d ' ')"
  if [[ "$prefix_count" -gt 1 ]]; then
    add_prefix_namespace_model "$model"
  fi

  # If this model has no non-deprecated entries at all, color the model header red.
  model_all_deprecated=1
  if awk -F'\t' '$3==""' "$tmp" | grep -q .; then
    model_all_deprecated=0
  fi

  if [[ "$model_all_deprecated" -eq 1 ]]; then
    printb "${RED}${model}/${RESET}"
  else
    echo "${model}/"
  fi

  # Print grouped tree: prefix then its versions as children.
  cut -f1 "$tmp" | sort -u | while read -r prefix; do
    # Emit version leaves (once per prefix)
    versions_tmp="$(mktemp)"
    awk -F'\t' -v p="$prefix" '$1==p {print $2"\t"$3"\t"$4}' "$tmp" | sort -u > "$versions_tmp"

    # Determine if prefix has >1 non-deprecated version leaf (version != "" and deprecated == "")
    non_deprecated_version_count=$(awk -F'\t' '$1 != "" && $2 == ""' "$versions_tmp" | cut -f1 | sort -u | wc -l | tr -d ' ')
    if [[ "$non_deprecated_version_count" -gt 1 ]]; then
      add_version_namespace_key "${model}|${prefix}"
    fi

    # If this prefix has no non-deprecated leaves, color the prefix red.
    prefix_all_deprecated=1
    if awk -F'\t' '$2==""' "$versions_tmp" | grep -q .; then
      prefix_all_deprecated=0
    fi

    if [[ "$prefix_all_deprecated" -eq 1 ]]; then
      printb "  └─ ${RED}${prefix}${RESET}"
    else
      echo "  └─ $prefix"
    fi

    # Date versions first (newest date in green), then V* versions.
    date_versions=$(awk -F'\t' '$1 ~ /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/ {print $1}' "$versions_tmp" | sort -r)
    other_versions=$(awk -F'\t' '$1 !~ /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/ && $1 != "" {print $1}' "$versions_tmp" | sort -u)

    # Count leaves for this prefix (dates + other versions + deprecated-only + latest)
    n_dates=$(printf '%s\n' $date_versions | sed '/^$/d' | wc -l | tr -d ' ')
    n_other=$(printf '%s\n' $other_versions | sed '/^$/d' | wc -l | tr -d ' ')
    has_deprecated_only=0
    if awk -F'\t' '$1=="" && $2!=""' "$versions_tmp" | grep -q .; then
      has_deprecated_only=1
    fi
    has_latest=0
    if awk -F'\t' '$1=="" && $2==""' "$versions_tmp" | grep -q .; then
      has_latest=1
    fi
    leaf_count=$((n_dates + n_other + has_deprecated_only + has_latest))

    # Determine the "best" non-deprecated version for coloring.
    # Preference: newest date (YYYY-MM-DD). If none, highest numeric V* (e.g. V2). If none, none.
    best_version=""

    best_date=$(awk -F'\t' '$1 ~ /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/ && $2=="" {print $1}' "$versions_tmp" | sort -r | head -n1)
    if [[ -n "$best_date" ]]; then
      best_version="$best_date"
    else
      best_vnum=$(awk -F'\t' '$1 ~ /^V[0-9]+$/ && $2=="" {print $1}' "$versions_tmp" | sort -V | tail -n1)
      if [[ -n "$best_vnum" ]]; then
        best_version="$best_vnum"
      fi
    fi

    for v in $date_versions; do
      dep="$(awk -F'\t' -v vv="$v" '$1==vv && $2!="" {print $2; exit}' "$versions_tmp")"
      sha="$(awk -F'\t' -v vv="$v" '$1==vv {print $3; exit}' "$versions_tmp")"

      if [[ -n "$dep" ]]; then
        # Deprecated date version: version and marker are red.
        # Still record in plan as skipped+deprecated.
        printb "    └─ ${RED}$v${RESET} [${RED}$dep${RESET}] (${sha})"
        emit_plan_line "$model" "$prefix" "$v" "$sha" "skip" "deprecated"
        continue
      fi

      # Supported legacy (explicitly opted-in): yellow + label.
      if is_supported_legacy "${model}|${prefix}|${v}"; then
        printb "    └─ ${YELLOW}$v${RESET} (${sha}) ${YELLOW}(supported legacy)${RESET}"
        emit_plan_line "$model" "$prefix" "$v" "$sha"
        continue
      fi

      # Not deprecated
      if [[ "$leaf_count" -eq 1 ]]; then
        # Single non-deprecated leaf => green
        printb "    └─ ${GREEN}$v${RESET} (${sha})"
        emit_plan_line "$model" "$prefix" "$v" "$sha"
      elif [[ -n "$best_version" && "$v" == "$best_version" ]]; then
        # Best version => green
        printb "    └─ ${GREEN}$v${RESET} (${sha})"
        emit_plan_line "$model" "$prefix" "$v" "$sha"
      else
        # Non-best => grey
        printb "    └─ ${GREY}$v${RESET} (${sha})"
        emit_plan_line "$model" "$prefix" "$v" "$sha" "skip"
      fi
    done

    for v in $other_versions; do
      dep="$(awk -F'\t' -v vv="$v" '$1==vv && $2!="" {print $2; exit}' "$versions_tmp")"
      sha="$(awk -F'\t' -v vv="$v" '$1==vv {print $3; exit}' "$versions_tmp")"

      if [[ -n "$dep" ]]; then
        # Deprecated non-date version: version and marker are red.
        # Still record in plan as skipped+deprecated.
        printb "    └─ ${RED}$v${RESET} [${RED}$dep${RESET}] (${sha})"
        emit_plan_line "$model" "$prefix" "$v" "$sha" "skip" "deprecated"
        continue
      fi

      # Not deprecated
      if is_supported_legacy "${model}|${prefix}|${v}"; then
        printb "    └─ ${YELLOW}$v${RESET} (${sha}) ${YELLOW}(supported legacy)${RESET}"
        emit_plan_line "$model" "$prefix" "$v" "$sha"
      elif [[ "$leaf_count" -eq 1 ]]; then
        printb "    └─ ${GREEN}$v${RESET} (${sha})"
        emit_plan_line "$model" "$prefix" "$v" "$sha"
      elif [[ -n "$best_version" && "$v" == "$best_version" ]]; then
        printb "    └─ ${GREEN}$v${RESET} (${sha})"
        emit_plan_line "$model" "$prefix" "$v" "$sha"
      else
        printb "    └─ ${GREY}$v${RESET} (${sha})"
        emit_plan_line "$model" "$prefix" "$v" "$sha" "skip"
      fi
    done

    # Deprecated-only (no version)
    if awk -F'\t' '$1=="" && $2!=""' "$versions_tmp" | grep -q .; then
      sha="$(awk -F'\t' '$1=="" && $2!="" {print $3; exit}' "$versions_tmp")"
      printb "    └─ [${RED}DEPRECATED${RESET}] (${sha})"
      # Record in plan using a sentinel version token so the line stays parseable.
      emit_plan_line "$model" "$prefix" "DEPRECATED" "$sha" "skip" "deprecated"
    fi

    # Unversioned normal file
    if awk -F'\t' '$1=="" && $2==""' "$versions_tmp" | grep -q .; then
      sha="$(awk -F'\t' '$1=="" && $2=="" {print $3; exit}' "$versions_tmp")"
      # If there are other versioned leaves, the unversioned file is legacy (not latest).
      if [[ "$leaf_count" -eq 1 ]]; then
        printb "    └─ ${GREEN}latest${RESET} (${sha})"
      elif [[ "$n_dates" -gt 0 || "$n_other" -gt 0 ]]; then
        printb "    └─ ${GREY}legacy${RESET} (${sha})"
      else
        echo "    └─ latest (${sha})"
      fi
    fi

    rm -f "$versions_tmp"
  done

  rm -f "$tmp"

  echo
done

echo "\nPlan written to $PLAN_OUT" >&2