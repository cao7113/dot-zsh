# Tied variables

在 Zsh 中，`$path` 和 `$fpath` 是**关联变量（Tied Variables）**。这是 Zsh 为了解决 Shell 脚本中“字符串处理低效”而引入的一种高级特性。

### 1. 核心定义与背景

在传统 Shell（如 sh/bash）中，环境变量通常是**冒号分隔的字符串**（例如 `PATH="/usr/bin:/bin"`）。这种格式对机器友好，但对开发者来说，想在脚本里给它增加、删除一个目录需要写复杂的 `sed` 或 `awk`。

Zsh 引入了 **“变量绑定（Tying）”** 机制：

- **大写变量（如 `$PATH`）**：保持标准的冒号分隔字符串，确保兼容外部程序。
- **小写变量（如 `$path`）**：对应的 **Zsh 数组**。

当你修改数组 `$path` 时，Zsh 会**自动同步**修改字符串 `$PATH`；反之亦然。

---

### 2. `$path` vs `$fpath`

#### **$path (Command Search Path)**

- **用途**：寻找可执行二进制文件或脚本。
- **技术背景**：它对应全局环境变量 `$PATH`。
- **操作技巧**：你可以直接用数组语法添加路径，且利用 `typeset -U` 自动去重。

```zsh
typeset -U path  # 确保 path 数组中没有重复项
path=(/opt/homebrew/bin $path) # 将新路径加到最前面

```

#### **$fpath (Function Search Path)**

- **用途**：寻找 **自动加载函数（Autoloaded functions）** 和 **补全脚本（Completions）**。
- **技术背景**：它对应 `$FPATH`。当你执行一个尚未定义的命令时，Zsh 会去 `$fpath` 目录里找同名文件。
- **常见场景**：安装 `oh-my-zsh` 插件或 `zsh-completions` 时，它们会将自己的目录加入 `$fpath`。

```zsh
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit # 初始化补全系统

```

---

### 3. 还有哪些类似的关联变量？

Zsh 内置了几个非常重要的“双胞胎”变量：

| 数组变量 (Array) | 标量变量 (Scalar/String) | 用途                                                |
| ---------------- | ------------------------ | --------------------------------------------------- |
| **`$path`**      | **`$PATH`**              | 执行程序搜索路径                                    |
| **`$fpath`**     | **`$FPATH`**             | 自定义函数和补全脚本路径                            |
| **`$cdpath`**    | **`$CDPATH`**            | `cd` 命令的搜索路径（让你直接 `cd` 到常用深层目录） |
| **`$manpath`**   | **`$MANPATH`**           | 手册页（man page）搜索路径                          |
| **`$mailpath`**  | **`$MAILPATH`**          | 检查新邮件的目录列表                                |

---

### 4. 为什么要这样设计？（技术优势）

1. **操作的高级性**：你可以直接使用 Zsh 的数组切片。例如，删除路径中的最后一项：`path[-1]=()`。
2. **性能优化**：数组操作在 Shell 内存中完成。如果你频繁对字符串进行 `split`（拆分）和 `join`（合并），开销会大很多。
3. **防错性**：通过 `typeset -U path`，你可以反复 source 你的配置文件，而不用担心你的 `$PATH` 变量变得越来越长。

---

### 5. 如何定义自己的关联变量？

你也可以模仿这种机制，定义自己的字符串与数组绑定：

```zsh
# 定义一个名为 mylist 的数组，并将其与标量 MYLIST 绑定
# -T (tie), 指定分隔符为冒号 :
typeset -T MYLIST mylist :

mylist=(apple banana cherry)
echo $MYLIST  # 输出: apple:banana:cherry

MYLIST="red:green:blue"
echo $mylist[1] # 输出: red

```

### 总结

`$path` 和 `$fpath` 是 Zsh 迈向“现代编程语言”的重要一步。**在你的脚本中，永远优先操作小写的 `$path` 数组**，因为这能利用 Zsh 强大的数组处理能力，避免字符串解析带来的 Bug。
