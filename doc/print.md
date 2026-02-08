# print vs echo

在 Zsh 中，`print` 是一个比传统的 `echo` 强大得多的内置命令。它不仅速度快，而且集成了格式化、颜色处理和路径展开等多种功能。

以下是 Zsh `print` 的经典用法分类：

---

### 1. 颜色与样式（`-P` 参数）

这是 `print` 最受欢迎的功能。`-P` (Prompt expansion) 允许你像配置终端提示符一样使用转义序列，无需记忆复杂的 ANSI 颜色码。

```zsh
# %F{颜色名} 开启颜色，%f 关闭颜色
print -P "%F{red}Error:%f Something went wrong."
print -P "%B%F{yellow}Warning:%f%b This is bold."
print -P "%K{blue}%F{white} Info %f%k 背景色示例"

```

- **常用转义：** `%B` (加粗), `%U` (下划线), `%S` (反色)。

---

### 2. 格式化输出（`-f` 参数）

类似于 C 语言的 `printf`。当你需要精确对齐数据或控制小数点位数时非常有用。

```zsh
# 自动换行需要手动加 \n
print -f "Name: %-10s | Score: %d\n" "Alice" 95 "Bob" 88

```

---

### 3. 处理数组（`-l` 与 `-c`）

这是 `echo` 做不到的地方，非常适合调试数组或显示文件列表。

- **`-l` (Line)**：每行输出一个元素。
- **`-c` (Column)**：自动按列对齐（类似 `ls` 的效果）。

```zsh
items=(apple banana cherry date)

# 每行一个
print -l $items

# 自动分列显示
print -c $items

```

---

### 4. 输出到特定位置（`-u` 与 `-s`）

- **`-u` (Unit)**：输出到文件描述符。最常用的是 `print -u2` 输出到 stderr（错误流）。
- **`-s` (Stack)**：将内容推送到命令历史记录中（但不执行）。

```zsh
# 将错误信息发往 stderr
print -u2 "This is an error message."

# 把命令塞进 history，按向上箭头就能看到
print -s "git commit -m 'Quick fix'"

```

---

### 5. 原样输出（`-r` 参数）

当你输出的内容包含反斜杠 `\` 或其他特殊字符时，`echo` 往往会自作聪明地转义，而 `print -r` (Raw) 会原样输出。

```zsh
# echo 会把 \n 变成换行，print -r 不会
print -r "C:\Users\Name"

```

---

### 6. 路径与日期展开（配合 `-P`）

除了颜色，`-P` 还能直接打印系统状态：

```zsh
print -P "当前时间: %D{%H:%M:%S}"
print -P "当前目录: %~"
print -P "当前用户: %n"

```

---

### 总结对比

| 命令            | 推荐用法                   | 场景                                        |
| --------------- | -------------------------- | ------------------------------------------- |
| **`echo`**      | `echo "text"`              | 极其简单的字符串输出（为了跨 Shell 兼容）。 |
| **`print -P`**  | `print -P "%F{green}OK%f"` | 需要**颜色**或**美化**输出时。              |
| **`print -l`**  | `print -l $array`          | 调试**数组**或打印多行列表时。              |
| **`print -u2`** | `print -u2 "msg"`          | 编写函数脚本，需要**报错**到标准错误时。    |
| **`print -r`**  | `print -r "$var"`          | 输出内容包含**转义字符**（如路径）时。      |
