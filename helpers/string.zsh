function strlen() {
    local input="$1"
    # 如果没有参数则从标准输入读取
    if [ -z "$input" ]; then
        read -r input
    fi

    local chars=$(printf "$input" | wc -m | xargs)
    local bytes=$(printf "$input" | wc -c | xargs)

    printf "\033[1;32m内容:\033[0m %s\n" "$input"
    printf "\033[1;36m字符数:\033[0m %s\n" "$chars"
    printf "\033[1;33m字节数:\033[0m %s\n" "$bytes"
}
