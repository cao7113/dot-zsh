# pa @path
alias pa="print_array"

function print_array() {
    local -a target_arr
    local input="$1"

    # 1. 逻辑判断：如果输入以 @ 开头，提取变量名
    if [[ "$input" == @* ]]; then
        local var_name="${input#@}" # 去掉开头的 @
        # 使用 (P) 标志根据变量名动态获取数组内容
        target_arr=("${(@P)var_name}")
    elif [[ -z "$input" ]]; then
        # 默认使用 path
        target_arr=("${path[@]}")
    else
        # 如果不是以 @ 开头，则把所有参数当作普通数组元素处理
        target_arr=("$@")
    fi

    # 2. 检查数组是否有效
    if [[ ${#target_arr} -eq 0 ]]; then
        echo "❌ 数组为空或变量 '$input' 未定义"
        return 1
    fi

    # 3. 打印输出
    printf '%s\n' "${target_arr[@]}" | nl -w 2 -s ': '
}
