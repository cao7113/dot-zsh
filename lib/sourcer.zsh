
## source functions

# ------------------------------------------------------------------------------
# 递归加载指定目录下的所有 rc.zsh 文件
# 参数 $1: 目标根目录 (默认为当前脚本所在目录)
# 参数 $2: 要匹配的文件名 (默认为 rc.zsh)
# ------------------------------------------------------------------------------
function source_dir_files() {
  local current_script="${${(%):-%x}:A}"
  local caller_file="${${funcfiletrace[1]%:*}:A}"
  
  local base_dir="${1:-${caller_file:h}}"
  local target_file="${2:-rc.zsh}"
  local depth="${3:-${DEPTH:-0}}"

  # 1. 确定搜索范围
  local glob_pattern
  if [[ "$depth" == "0" ]]; then
    glob_pattern="${base_dir%/}/$target_file(NA)" # (N-.A)
  elif [[ "$depth" == "1" ]]; then
    # 匹配所有一级子目录下的目标文件
    glob_pattern="${base_dir%/}/*/$target_file(NA)" # (N-.A)
  else
    echo "Error: Invalid depth '$depth'. Only 0 or 1 are supported." 1>&2
    return 1
  fi

  [[ -n "$DEBUG" ]] && {
    echo "--- [DEBUG] Glob: $glob_pattern"
  }

  # 2. 遍历并手动过滤排除目录
  local _rc_path start_time
  for _rc_path in ${~glob_pattern}; do
    
    # # 排除逻辑：排除包含 .git, node_modules 的路径
    # if [[ "$_rc_path" =~ "\.(git|node_modules)/" ]]; then
    #    [[ -n "$DEBUG" ]] && echo "Skipping ignored path: $_rc_path"
    #    continue
    # fi

    [[ -n "$DEBUG" ]] && echo "--- [INFO] Loading: $_rc_path"

    # 排除自身逻辑
    [[ "$_rc_path" == "$caller_file" ]] && continue
    [[ "$_rc_path" == "$current_script" ]] && continue

    if [[ -n "$DRY" ]]; then
      echo "[DRY] source $_rc_path"
      continue
    fi

    # [[ -n "$DEBUG" ]] && echo "--- [INFO] Sourcing: $_rc_path"

    # 3. 性能监测加载
    start_time=$EPOCHREALTIME

    safe_source "$_rc_path"
    
    local duration=$(( $EPOCHREALTIME - start_time ))
    if (( duration > 0.05 )); then
      printf "--- [WARN] %s (%.2fms) ⚠️\n" "${_rc_path}" "$(( duration * 1000 ))"
    else
      [[ -n "$DEBUG" ]] && printf "--- [INFO] Sourced %s (%.2fms)\n" "${_rc_path}" "$(( duration * 1000 ))"
    fi
  done
}

function safe_source() {
  # 1. 严格参数检查：使用 (( )) 处理数值，性能略高
  if (( $# == 0 )); then
    print -u2 "Usage: ${0} <file>"
    return 1
  fi

  local file="$1"
  
  # 2. 精确匹配：确保路径展开正确（~ 等符号）
  # 使用 :A 修饰符可以将路径转为绝对路径，方便在 DEBUG 中查看全称
  local abs_file="${file:A}"

  if [[ -f "$file" ]]; then
    # 3. 调试输出：使用 print -P 支持 Zsh 转义字符（如颜色）
    [[ -n "$DEBUG" ]] && print -P "%F{green}--- [INFO] safe source file: %f$abs_file"
    
    # 4. 执行 source
    source "$file"
  else
    # 5. 错误追溯细化
    local caller_info="${funcfiletrace[1]:-unknown_location}"
    local caller_file="${caller_info%:*}"
    local caller_line="${caller_info#*:}"

    print -u2 -P "%F{red}Error:%f Invalid source file: %B$file%b"
    print -u2 -P "  %F{yellow}At:%f ${caller_file:t} (Line: $caller_line)"
    print -u2 -P "  %F{yellow}Full Path:%f ${caller_file:A}"
    
    # 如果有额外参数，一并输出便于调试
    (( $# > 1 )) && print -u2 "  Context Args: ${@[2,-1]}"
    
    return 2
  fi
}