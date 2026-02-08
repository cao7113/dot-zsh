# setopt AUTO_CD

# setopt CORRECT
# input sl for ls
# zsh: correct 'sl' to 'ls' [nyae]? e
# n (no)：不纠正。按原样执行你输入的 sl。通常这会导致一个 command not found 错误。
# y (yes)：纠正。接受建议，改为执行 ls。这是最常用的选项。
# a (abort)：放弃。直接取消这一行命令，什么都不执行，返回到新的提示符下。
# e (edit)：编辑。不执行命令，而是把这行命令重新放回你的输入缓冲区，让你手动修改。