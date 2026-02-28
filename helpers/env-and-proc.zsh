alias pid="echo $$"
alias psproc="ps -p $$" # ps current running process

# 获取匹配某个进程的pids，如 nginx的
function grepproc(){
  [ $# -lt 1 ] && return 1
  pattern=$1
  ps aux | grep $pattern | grep -v grep
}

function run_info(){ 
  local -a info
  info=(
    "user"  "$(id -un)"
    "group" "$(id -gn)"
    "host"  "${HOST:-$(hostname)}"
    "time"  "$(date +%T)"
  )

  echo "## run info:"
  # 步长为 2 遍历数组（处理键值对）
  local k v
  for k v in "${info[@]}"; do
    # %-10s 表示左对齐，宽度为 10
    printf "%-15s %s\n" "$k" "$v"
  done
}

# function penv(){
#   [ $# -lt 1 ] && echo Usage: $0 pid_number && return 1  #exit 1
#   pid=${1}
#   cat /proc/$pid/environ  | tr '\0' '\n' | sort
# }

# # beautiful linux /proc/$pid/environ format
# xargs --null --max-args=1 < /proc/$pid/environ