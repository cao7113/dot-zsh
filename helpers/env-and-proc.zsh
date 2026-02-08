# 获取匹配某个进程的pids，如 nginx的
function grepproc(){
  [ $# -lt 1 ] && return 1
  pattern=$1
  ps aux | grep $pattern | grep -v grep
}

# function penv(){
#   [ $# -lt 1 ] && echo Usage: $0 pid_number && return 1  #exit 1
#   pid=${1}
#   cat /proc/$pid/environ  | tr '\0' '\n' | sort
# }

# # beautiful linux /proc/$pid/environ format
# xargs --null --max-args=1 < /proc/$pid/environ