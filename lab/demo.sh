#!/bin/zsh

#!/bin/sh
# 第一行写了 #!/bin/sh，这意味着这个脚本是交给 sh（在 macOS 上通常是 bash 的 POSIX 模式，在 Linux 上可能是 dash）来执行的，而不是 Zsh。

# echo $SHELL 为什么输出 /bin/zsh？
# $SHELL 是一个环境变量，指向你当前登录的用户默认 Shell。即使你在跑一个 python 脚本或者 sh 脚本，这个变量的值依然是 /bin/zsh。它并不代表当前脚本正在运行的环境。
echo $SHELL # /bin/zsh

# dsh info # command not found: dsh, should explicit source it

echo "## ok: run command in PATH"
zdemo

typeset -a arr
arr=(1 2)
# why print: command not found --> print是zsh的函数
print -l $arr