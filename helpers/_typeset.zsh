alias tp="typeset"

# typeset -L 5 var：左对齐，宽度为 5（自动截断或补齐空格）。
# typeset -u var：自动转为大写。
# typeset -l var：自动转为小写。
# typeset -x abc # typeset +x abc # 跨界导出
# typeset -x # show all exported vars
# typeset -ft my_func # 开启该函数的追踪模式。当你调用 my_func 时，终端会打印出该函数执行的每一步细节，而不会影响其他函数的运行。这是调试神器。
# typeset -fr my_func # 将函数设为只读，防止在复杂的脚本执行过程中被无意间覆盖

# (( $+functions[name] ))
# # 加载目录下所有非隐藏文件
# for func in ~/.zsh/functions/*(N.:t); do
#     autoload -Uz "$func"
# done

# functions: 本质上是 typeset -f 的别名，专门用于处理 Shell 函数

# $functions (内建关联数组)
# Zsh 有一个特殊的关联数组（Dictionary）叫做 $functions。
# 它的 键 (Keys) 是所有已定义的函数名。
# 它的 值 (Values) 是该函数的定义内容（即代码体）。
# 当你执行 echo $functions[hello]，你会看到 hello 函数的源代码

# 它与 autoload 的微妙关系
# 这里有一个新手经常踩的坑：autoload 并不等于定义函数。
# 当你执行 autoload -Uz my_func 时，Zsh 只是做了一个标记，此时 $+functions[my_func] 已经是 1 了（因为它被标记为“待加载”）。
# 但是，该函数的内容只有在第一次被调用时才会从文件系统中读取。
# 如果你想检查函数是否“真正被执行过/完全加载了”，可以结合 zstyle 或检查内部私有变量。