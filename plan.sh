source ./env.sh

DRY_RUN=0
DIFF_ONLY=0
APPLY=0
LIST_API_CHANGES=0
NAME_ONLY=0
STAGE=1
CHECK=0

CHECK_FAILED=0

printb() {
  printf "%b\n" "$1"
}

breadcrumb_path_for_root() {
  local root="$1" out_name="$2"
  echo "$root/$out_name/.codegen-source"
}

breadcrumb_actual_sha_at() {
  local root="$1" out_name="$2"
  local crumb
  crumb="$(breadcrumb_path_for_root "$root" "$out_name")"
  [[ -f "$crumb" ]] || return 1

  awk -F= '
    /^json_spec_blob_sha=/{print $2; found=1; exit}
    /^sha=/{print $2; found=1; exit}
    END{if(!found) exit 1}
  ' "$crumb" 2>/dev/null
}

breadcrumb_matches_target() {
  local out_name="$1" expected_short="$2"
  local actual

  actual="$(breadcrumb_actual_sha_at "$FINAL_LIB_ROOT" "$out_name" 2>/dev/null || true)"
  [[ -n "$actual" ]] || return 1

  local actual_short="$actual"
  [[ ${#actual_short} -gt 7 ]] && actual_short="${actual_short:0:7}"

  [[ "$actual_short" == "$expected_short" ]]
}

emit_check_status() {
  local api_id="$1" status="$2" sha="$3" extra="${4:-}"

  local c_reset="\033[0m"
  local c_red="\033[31m"
  local c_green="\033[32m"
  local c_yellow="\033[33m"
  local c_dim="\033[90m"

  local c=""
  case "$status" in
    ok) c="$c_green" ;;
    supported) c="$c_yellow" ;;
    legacy) c="$c_dim" ;;
    deprecated) c="$c_red" ;;
    missing) c="$c_red" ;;
    stale) c="$c_yellow" ;;
    *) c="" ;;
  esac

  local s="$sha"
  [[ ${#s} -gt 7 ]] && s="${s:0:7}"

  if [[ -n "$c" ]]; then
    if [[ -n "$extra" ]]; then
      printf "%b[%s]%b\t%s\t%s\t%s\n" "$c" "$status" "$c_reset" "$s" "$api_id" "$extra"
    else
      printf "%b[%s]%b\t%s\t%s\n" "$c" "$status" "$c_reset" "$s" "$api_id"
    fi
  else
    if [[ -n "$extra" ]]; then
      printf "[%s]\t%s\t%s\t%s\n" "$status" "$s" "$api_id" "$extra"
    else
      printf "[%s]\t%s\t%s\n" "$status" "$s" "$api_id"
    fi
  fi
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --diff-only)
      DIFF_ONLY=1
      shift
      ;;
    --apply)
      APPLY=1
      shift
      ;;
    --list-api-changes)
      LIST_API_CHANGES=1
      shift
      ;;
    --name-only)
      NAME_ONLY=1
      shift
      ;;
    --stage)
      STAGE=1
      shift
      ;;
    --check)
      CHECK=1
      shift
      ;;
    *)
      shift
      ;;
  esac
done

if [[ "$CHECK" == "1" ]]; then
  DRY_RUN=1
  STAGE=0
  DIFF_ONLY=0
  APPLY=0
  NAME_ONLY=0
fi

if [[ "$LIST_API_CHANGES" == "1" ]]; then
  STAGE=0
  DIFF_ONLY=0
  APPLY=0
  NAME_ONLY=0
fi

while IFS= read -r line; do
  model="$(echo "$line" | cut -d/ -f1)"
  rest="${line#*/}"
  prefix="${rest%@*}"
  version_sha="${rest#*@}"
  version="${version_sha%%#*}"
  sha_flags="${version_sha#*#}"
  sha="${sha_flags%%;*}"
  flags_part="${sha_flags#*;}"
  flags_part="${flags_part// /}"

  api_id="$model/$prefix@$version"

  if [[ "$CHECK" == "1" ]]; then
    if has_flag "$flags_part" "skip_deprecated"; then
      emit_check_status "$api_id" "deprecated" "$sha"
      continue
    fi

    if has_flag "$flags_part" "skip_legacy" && ! has_flag "$flags_part" "supported_legacy"; then
      emit_check_status "$api_id" "legacy" "$sha"
      continue
    fi

    out_name_base="$model"
    if has_flag "$flags_part" "use_prefix_namespace"; then
      out_name_base="${model}-${prefix}"
    fi

    out_name="$out_name_base"
    if has_flag "$flags_part" "use_version_namespace"; then
      ver_tok="$(sanitize_version_token "$version")"
      out_name="${out_name_base}-${ver_tok}"
    fi

    if breadcrumb_matches_target "$out_name" "$sha"; then
      if has_flag "$flags_part" "supported_legacy"; then
        emit_check_status "$api_id" "supported" "$sha"
      else
        emit_check_status "$api_id" "ok" "$sha"
      fi
    else
      actual="$(breadcrumb_actual_sha_at "$FINAL_LIB_ROOT" "$out_name" 2>/dev/null || true)"
      if [[ -z "$actual" ]]; then
        emit_check_status "$api_id" "missing" "$sha"
      else
        emit_check_status "$api_id" "stale" "$sha" "actual=${actual:0:7}"
      fi
      CHECK_FAILED=1
    fi

    continue
  fi

  # Existing generation/staging logic here (unchanged)...

done < "$PLAN_OUT"

if [[ "$CHECK" == "1" ]]; then
  [[ "$CHECK_FAILED" == "1" ]] && exit 2
  exit 0
fi

# Existing early exit for --list-api-changes or other modes here...