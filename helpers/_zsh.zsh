# du -kh --max-depth=1
# lsof -p bundle
# lsof -p 31822

#sudo passwd doger     # 设置密码
#sudo passwd doger -d  # 移除密码，密码登录失效，任何密码不能登录

# mktemp -d # tmp dir

# vipw vigr
# alias realpath='readlink -f'
#screen, byotu, tmux
#alias fp="byobu" #fenping

# # 当前在: ~/dev/project1/src
# cd project1 project2
# # 自动切换到: ~/dev/project2/src

# ls **/*.zsh(.)     # 递归找所有普通文件
# ls **/*(m-5)      # 递归查找过去 5 天内修改过的文件
# ls **/*(L+100k)   # 递归查找大小超过 100kb 的文件


#  But, as John points out:
#    if [ -t 0 ] works ... when you're logged in locally
#    but fails when you invoke the command remotely via ssh.
#    So for a true test you also have to test for a socket.
# Return:
#   0: non-interactive, login shell
#   1: interactive, non-login shell
function is_interactive_sh(){
  [[ -t "0" || -p /dev/stdin ]] && return 0 || return 1
}

# parameters
#  $1 : the question to ask
#  $2 : default answer (Y/N or empty)
function ask() {
  # 1. 检查参数 (使用更现代的 (( )) 算术评估)
  if (( $# < 1 )); then
    print "Error: Require at least one parameter!" >&2
    return 2
  fi

  local prompt default REPLY

  # 2. 预设逻辑
  case "${2:u}" in # :u 将变量转为大写处理，更兼容
    Y) prompt="Y/n"; default="Y" ;;
    N) prompt="y/N"; default="N" ;;
    *) prompt="y/n"; default=""  ;;
  esac

  while true; do
    # 3. Zsh 特有的 read 语法: read "变量名?提示语"
    # -k 1: 只读取一个字符（可选，如果你希望按键即触发）
    # 这里我们保持传统的 Enter 确认模式
    read "REPLY?$1 [$prompt] "

    # 4. 处理默认值 (如果直接按 Enter)
    : ${REPLY:=$default}

    # 5. 匹配返回
    case "${REPLY:u}" in # 统一转大写匹配
      Y*) return 0 ;;
      N*) return 1 ;;
      *)  print "Please answer Y or N." ;;
    esac
  done
}
