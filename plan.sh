source ./env.sh

RED="\033[31m"
GREEN="\033[32m"
GREY="\033[90m"
RESET="\033[0m"

printb() {
  # Interpret backslash escapes reliably (ANSI colors, etc.)
  printf '%b\n' "$1"
}

MODEL_DIRS=$(find "$MODELS_DIR" -mindepth 1 -maxdepth 1 -type d | sort)

echo "Listing files inside each model directory:"

# Iterate models in a stable order
for model_dir in $MODEL_DIRS; do
  model="$(basename "$model_dir")"

  tmp="$(mktemp)"

  # Collect (prefix, version, deprecated) tuples for this model.
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

    printf '%s\t%s\t%s\n' "$prefix" "$version" "$deprecated" >> "$tmp"
  done

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
    awk -F'\t' -v p="$prefix" '$1==p {print $2"\t"$3}' "$tmp" | sort -u > "$versions_tmp"

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

      if [[ -n "$dep" ]]; then
        # Deprecated date version: version and marker are red.
        printb "    └─ ${RED}$v${RESET} [${RED}$dep${RESET}]"
        continue
      fi

      # Not deprecated
      if [[ "$leaf_count" -eq 1 ]]; then
        # Single non-deprecated leaf => green
        printb "    └─ ${GREEN}$v${RESET}"
      elif [[ -n "$best_version" && "$v" == "$best_version" ]]; then
        # Best version => green
        printb "    └─ ${GREEN}$v${RESET}"
      else
        # Non-best => grey
        printb "    └─ ${GREY}$v${RESET}"
      fi
    done

    for v in $other_versions; do
      dep="$(awk -F'\t' -v vv="$v" '$1==vv && $2!="" {print $2; exit}' "$versions_tmp")"
      if [[ -n "$dep" ]]; then
        # Deprecated non-date version: version and marker are red.
        printb "    └─ ${RED}$v${RESET} [${RED}$dep${RESET}]"
      else
        # Not deprecated
        if [[ "$leaf_count" -eq 1 ]]; then
          printb "    └─ ${GREEN}$v${RESET}"
        elif [[ -n "$best_version" && "$v" == "$best_version" ]]; then
          printb "    └─ ${GREEN}$v${RESET}"
        else
          printb "    └─ ${GREY}$v${RESET}"
        fi
      fi
    done

    # Deprecated-only (no version)
    if awk -F'\t' '$1=="" && $2!=""' "$versions_tmp" | grep -q .; then
      printb "    └─ [${RED}DEPRECATED${RESET}]"
    fi

    # Unversioned normal file
    if awk -F'\t' '$1=="" && $2==""' "$versions_tmp" | grep -q .; then
      # If there are other versioned leaves, the unversioned file is legacy (not latest).
      if [[ "$leaf_count" -eq 1 ]]; then
        printb "    └─ ${GREEN}latest${RESET}"
      elif [[ "$n_dates" -gt 0 || "$n_other" -gt 0 ]]; then
        printb "    └─ ${GREY}legacy${RESET}"
      else
        echo "    └─ latest"
      fi
    fi

    rm -f "$versions_tmp"
  done

  rm -f "$tmp"

  echo
done