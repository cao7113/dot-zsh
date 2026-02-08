#!/bin/zsh

# 1. 加载 datetime 模块
zmodload zsh/datetime

# 定义一个函数，模拟你在 dsh 框架中的逻辑
get_current_time() {
    # 1. 显式声明局部变量，函数执行完后，它们会被自动销毁
    local my_time 
    
    # 2. 使用 -s 参数将结果“注入”到变量中，而不是直接打印
    strftime -s my_time "[%H:%M:%S]" $EPOCHSECONDS
    
    echo "函数内部获取的时间: $my_time"
}

get_current_time

# 验证：查看该命令是否为内置（Built-in）
which strftime