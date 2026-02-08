# Print paths

在 Zsh 中，利用 `print` 配合数组展开标志（Parameter Expansion Flags）是处理 `$PATH` 最优雅的方式。

这里有几种从“实用”到“极致美观”的方案：

### 1. 经典快速方案 (每行一个)

利用 `print -l` 配合 Zsh 对环境变量的自动数组映射。在 Zsh 中，`$path`（小写）是 `$PATH`（大写）的关联数组版本。

```zsh
# -l 表示每行打印一个数组元素
print -l $path

```

---

### 2. 带序号的美化方案 (最推荐)

如果你想要序号，可以利用 Zsh 的数组下标特性。

```zsh
# 使用遍历，配合 print -P 渲染颜色
for i in {1..${#path}}; do
  print -P "%F{blue}%3d%f  ${path[$i]}"
done

```

- **`%3d`**: 序号占 3 位，右对齐。
- **`%F{blue}...%f`**: 将序号设为蓝色，方便区分路径。

---

### 3. “一行流”高级方案 (带序号)

如果你喜欢用一行代码解决，可以利用 `print -f`（类似 printf）：

```zsh
print -f "%3d  %s\n" ${path[@]:kv} | sed 'N;s/\n/ /' # 这种略显复杂
# 更简单的 Zsh 原生写法：
local n=1; print -l "${path[@]/#/$((n++))  }"

```

---

### 4. 极致美观版：带路径检查

作为一个开发者，你可能想知道 `$PATH` 中哪些路径其实是**失效**的（比如被删掉的文件夹）。

```zsh
function path_pretty() {
  local i=1
  local color
  for p in $path; do
    # 检查目录是否存在，不存在则显示红色
    if [[ -d $p ]]; then color="green"; else color="red"; fi

    print -P "%F{blue}%2d%f  %F{$color}$p%f"
    ((i++))
  done
}

```

---

### 技巧解析

- **`$path` (小写)**: Zsh 独有的特性，它是一个真正的数组，而 `$PATH` 是以冒号分隔的字符串。对 `$path` 遍历不需要手动 `split`。
- **`%F{color}`**: 这是 `print -P` 的魔法，支持 `red`, `blue`, `green`, `yellow`, `magenta`, `cyan`, `white`, `black` 或者 0-255 的颜色索引。
- **`${#path}`**: 获取路径数组的总长度。

**你想把这个功能封装成一个持久的别名（比如 `alias lpath='...'`）放进你的 `.zshrc` 吗？**
