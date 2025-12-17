source ./env.sh

RED="\033[31m"
GREEN="\033[32m"
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
  echo "$model/"

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

  # Print grouped tree: prefix then its versions as children.
  cut -f1 "$tmp" | sort -u | while read -r prefix; do
    echo "  └─ $prefix"

    # Emit version leaves. If there are no versions and not deprecated, print nothing further.
    awk -F'\t' -v p="$prefix" '$1==p {print $2"\t"$3}' "$tmp" | sort -u | while read -r version deprecated; do
      # Collect versions for this prefix into buckets
      versions_tmp="$(mktemp)"

      awk -F'\t' -v p="$prefix" '$1==p {print $2"\t"$3}' "$tmp" | sort -u > "$versions_tmp"

      # Separate date versions and non-date versions
      date_versions=$(awk -F'\t' '$1 ~ /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/ {print $1}' "$versions_tmp" | sort -r)
      other_versions=$(awk -F'\t' '$1 !~ /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/ && $1 != "" {print $1}' "$versions_tmp")

      first_date=1
      for v in $date_versions; do
        dep="$(awk -F'\t' -v vv="$v" '$1==vv && $2!="" {print $2; exit}' "$versions_tmp")"
        dep_mark=""
        if [[ -n "$dep" ]]; then
          dep_mark=" [${RED}$dep${RESET}]"
        fi

        if [[ "$first_date" -eq 1 ]]; then
          printb "    └─ ${GREEN}$v${RESET}${dep_mark}"
          first_date=0
        else
          printb "    └─ $v${dep_mark}"
        fi
      done

      for v in $other_versions; do
        dep="$(awk -F'\t' -v vv="$v" '$1==vv && $2!="" {print $2; exit}' "$versions_tmp")"
        if [[ -n "$dep" ]]; then
          printb "    └─ $v [${RED}$dep${RESET}]"
        else
          echo "    └─ $v"
        fi
      done

      # Handle deprecated-only case (no version, deprecated markdown)
      if awk -F'\t' '$1=="" && $2!=""' "$versions_tmp" | grep -q .; then
        printb "    └─ [${RED}DEPRECATED${RESET}]"
      fi

      # Handle unversioned normal file
      if awk -F'\t' '$1=="" && $2==""' "$versions_tmp" | grep -q .; then
        echo "    └─ latest"
      fi

      rm -f "$versions_tmp"
      continue
    done
  done

  rm -f "$tmp"

  echo
done