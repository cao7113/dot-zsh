## aliases

alias opts="getopt"
alias e="exit"
alias l="ls -lah"
alias has="type -a"
alias what="whence -a" # which -a
alias fn="whience -f"
alias t="task"

#alias c="clear" # use Ctrl+l instead
alias p="pwd"
# r # builtin r for repeat, Great!!! 
# r git
# dirs -v
alias his=history

# 语法：alias -s 后缀=程序
alias -s {md,txt}=vim
# alias -s {html,com}=open  # 在 macOS 上
# # 以后在终端输入：
# script.py    # 自动执行 python3 script.py
# README.md    # 自动执行 vim README.md
# google.com   # 自动在浏览器打开网页

## dsh

alias d="dsh"
# override d function from omz
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh
# function d () {
#   if [[ -n $1 ]]; then
#     dirs "$@"
#   else
#     dirs -v | head -n 10
#   fi
# }
# compdef _dirs d

alias o="dsh o"
alias dot="dotrc"

## vim
alias vi='vim'
alias vimrc='vi ~/.vimrc'
alias svi="sudo vi"