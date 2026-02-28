# Centrally manage aliases in alpha order as possible.
# see all aliases with `alias`

# 缩写常用管道
alias -g G='| grep -i'
alias -g L='| less'
alias -g M='| head -n 20'
alias -g CA='| pbcopy' # macOS 剪贴板

# # 使用方式：
# cat log.txt G "error" L
# ls -R M
# cat config.json CA

alias virc="vi ~/.vimrc"
