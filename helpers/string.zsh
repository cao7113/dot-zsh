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

    # print -P "%F{red}Error:%f Something went wrong."
}

# 函数名：sanitize_string
# 功能：将非字母数字字符替换为 -，并合并连续的 -
function sanitize_string() {
  local input="$1"
  local result
  
  # 1. 将所有非字母数字字符（标点 [:punct:] 和 空格 [:space:]）统一替换为 "-"
  #    这里使用 [^[:alnum:]] 匹配“非字母数字”
  result="${input//[^[:alnum:]]/-}"
  
  # 2. 压缩重复的 "-" 并去除首尾的 "-"
  #    (s:-:) : 按 "-" 分割成数组，空元素（重复生成的）会被自动丢弃
  #    (j:-:) : 用单个 "-" 将数组重新连接成字符串
  #    ${(j:-:)${(s:-:)result}} 这种嵌套写法是 Zsh 的精髓
  echo "${(j:-:)${(s:-:)result}}"
}

# 语法,含义
# ${#var},获取字符数量 (常用)
# ${(b)#var},获取字节数量
# ${(m)#var},获取视觉占用宽度 (排版对齐必选)