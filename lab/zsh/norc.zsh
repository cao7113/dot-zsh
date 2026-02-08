exec zsh -f

# 列出所有已经开启的选项
# setopt
# 列出所有选项及其开关状态
# setopt -o

# 选项,全称,精确含义
# -f,--no-rcs,"跳过所有配置文件。不加载 .zshrc, .zprofile 等。常用于排查是否是配置引起的问题（即“纯净模式”）。"
# -l,--login,登录 Shell。强制 Zsh 读取 /etc/zprofile 和 ~/.zprofile。通常用于确保加载完整的环境变量（如 $PATH）。
# -i,--interactive,交互式 Shell。开启后会读取 ~/.zshrc 并允许输入命令。如果不加这个，通常用于非交互式脚本执行。
# -c,(无),"执行命令字符串。例如 zsh -c ""ls -l""。执行完后立即退出。"