# see all aliases with `alias`
# NOTE: this file loaded before checkout profile, maybe overwrite
# keep this simple and mini

## dsh
alias d="dsh" # override d function from omz https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/directories.zsh
alias dot="dotrc"

alias e="exit"
alias l="ls -lah"
alias cmd="command"
alias has="type -a"
alias what="whence -a" # which -a
alias fun="whence -f" # functions xxx
alias opts="getopt"

#alias c="clear" # use Ctrl+l instead
# r # builtin r for repeat, Great!!! 
# r git
# dirs -v

# 语法：alias -s 后缀=程序
# alias -s {md,txt}=vim
# alias -s {html,com}=open  # 在 macOS 上
# # 以后在终端输入：
# script.py    # 自动执行 python3 script.py
# README.md    # 自动执行 vim README.md
# google.com   # 自动在浏览器打开网页

# 缩写常用管道
alias -g G='| grep -i'
alias -g L='| less'
alias -g H='| head -n 20'
alias -g CP='| pbcopy' # macOS 剪贴板
# # 使用方式：
# cat log.txt G "error" L
# ls -R H
# cat config.json CP
