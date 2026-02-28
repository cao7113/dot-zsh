## zsh info
alias zshcmd="command zsh"

function zsh(){
  local act=${1:-info}
  case $act in
    i|info)
      zsh_info
      ;;
    v|version)
      zsh --version
      ;;
    f|files)
      zsh_files
      ;;
    *)
      zshcmd "$@"
  esac
}

function zsh_info() {
  echo "## Shell info"
  echo "SHELL:        $SHELL" # which -a zsh
  echo "SHLVL:        $SHLVL"
  echo "ZSH_NAME:     $ZSH_NAME"
  echo "ZSH_VERSION:  $ZSH_VERSION" # zsh --version
  echo "ZSH:          $ZSH"   # omz config
}

function zsh_files() {
  ls -ld ~/.z*
}

function zsh_info_check() {
    echo "Checking for updates..."
    # 检查 brew 是否安装，且当前使用的是否为 brew 版 zsh
    [[ ! -x "$(command -v brew)" ]] && return
    [[ "$SHELL" != *"homebrew"* ]] && return

    local cache_file="${XDG_CACHE_HOME:-$HOME/.cache}/zsh_update_last_check"
    local today=$(date +%Y-%m-%d)

    # 每天只检查一次，避免频繁调用 brew 导致启动变慢
    if [[ ! -f "$cache_file" || "$(cat "$cache_file")" != "$today" ]]; then
        (
            # 在后台运行，不阻塞当前终端启动
            local latest_version=$(brew info zsh --json | jq -r '.[0].versions.stable' 2>/dev/null)
            local current_version=$ZSH_VERSION
            
            if [[ -n "$latest_version" && "$latest_version" != "$current_version" ]]; then
                echo -e "\n\033[1;33m[Update]\033[0m A new version of Zsh ($latest_version) is available!"
                echo -e "Current version: $ZSH_VERSION. Run \033[1;32mbrew upgrade zsh\033[0m to update.\n"
            fi
            # 更新检查日期
            mkdir -p "$(dirname "$cache_file")"
            echo "$today" > "$cache_file"
        ) &! # &! 表示在后台运行且不显示任务 ID
    fi
}

function zsh_clean_compdump(){
  # https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-reset-the-completion-cache
  # echo $ZSH_COMPDUMP

  ## completion with brew
  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
  # rm -f ~/.zcompdump; compinit
  # l $(brew --prefix)/share/zsh/site-functions
  
  # reset zcompinit cache
  rm -fr ~/.zcompdump*
  exec zsh -l
}

# alias root="sudo su"
# sudo passwd doger     # 设置密码
# sudo passwd doger -d  # 移除密码，密码登录失效，任何密码不能登录
# vipw vigr

# # 当前在: ~/dev/project1/src
# cd project1 project2
# # 自动切换到: ~/dev/project2/src

# du -kh --max-depth=1
# ls **/*.zsh(.)     # 递归找所有普通文件
# ls **/*(m-5)      # 递归查找过去 5 天内修改过的文件
# ls **/*(L+100k)   # 递归查找大小超过 100kb 的文件
# lsof -p bundle
# lsof -p 31822

#  But, as John points out:
#    if [ -t 0 ] works ... when you're logged in locally
#    but fails when you invoke the command remotely via ssh.
#    So for a true test you also have to test for a socket.
# Return:
#   0: non-interactive, login shell
#   1: interactive, non-login shell
function is_interactive_sh(){
  [[ -t "0" || -p /dev/stdin ]] && return 0 || return 1

  # # 检查是否为交互式 (返回 i 说明是)
  # [[ $- == *i* ]] && echo "Interactive"
  # # 检查是否为登录式 (返回 true 说明是)
  # [[ -o login ]] && echo "Login shell"
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
