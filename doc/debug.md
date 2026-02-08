# Debug

在 Zsh 开发中，`DEBUG=1` 确实是一个非常实用的**自定义**约定，但 Zsh 本身提供了从“语法检查”到“逐行追踪”的完整原生工具链。

以下是 Zsh 常见的调试技巧，按从浅入深的顺序排列：

---

### 1. 自定义 `DEBUG=1` 模式 (逻辑级调试)

正如你在代码中使用的，这属于**逻辑开关**。

- **做法**：在脚本中通过 `[[ -n "$DEBUG" ]]` 包裹 `echo` 或 `printf`。
- **优点**：输出清爽，只显示你关心的关键变量（如 `Pattern: /Users/rj/...`）。
- **用法**：`DEBUG=1 source_dir_files`。

### 2. 追踪执行：`set -x` 或 `setopt XTRACE` (运行级调试)

这是最强大的原生技巧。它会打印出脚本执行的**每一行**，并显示变量展开后的最终形态。

- **临时开启**：

```zsh
set -x
source_dir_files  # 执行时会看到每一行带 + 号的输出
set +x            # 关闭

```

- **局部开启**：如果你只想调试函数内部，可以利用 Zsh 的特性：

```zsh
functions -t source_dir_files  # 给特定函数开启追踪 (Tracing)
source_dir_files               # 只有这个函数会打印细节
functions +t source_dir_files  # 取消追踪

```

### 3. 语法检查：`zsh -n` (静态调试)

在运行复杂的 `.zshrc` 或脚本前，先检查是否有语法错误（如漏了 `fi` 或 `elif` 拼错）。

```zsh
zsh -n my_script.zsh

```

_它不会真的执行代码，只会扫描语法。_

### 4. 变量与函数内省 (状态调试)

当你不知道某个变量或函数现在的状态时：

- **`typeset -p var_name`**：精确查看变量的类型（关联数组？只读？）和当前值。
- **`functions function_name`**：直接打印出该函数的源码（如果你在当前 session 修改了它，这很有用）。
- **`which function_name`**：查看函数是从哪个文件加载的。

### 5. 性能调试：`zshprof` 或 `zprof`

如果你觉得启动变慢了：

1. 在 `.zshrc` 顶部加上 `zmodload zsh/zprof`。
2. 在底部加上 `zprof`。
3. 重新打开终端，你会看到一张表格，列出每个函数消耗的时间百分比。

---

### 6. 捕捉错误：`ERR_EXIT` 与 `DEBUG` Trap

你可以让 Zsh 在出错时立即停下，或者在每一行执行前运行特定代码。

```zsh
# 只要任何命令失败，立即停止脚本
setopt ERR_EXIT

# 每一行执行前打印当前行号
trap 'echo "Executing line $LINENO..."' DEBUG

```

### 总结建议：

- 如果你想看**逻辑流程**（比如 Glob 拼得对不对），用你的 `DEBUG=1`。
- 如果你想看**报错位置**（比如为什么报错 `bad math expression`），用 `functions -t`。
- 如果你想看**启动速度**，用 `zprof`。

**要不要我帮你给你的 `source_dir_files` 加一个更强大的局部 `set -x` 触发器，让你只需传一个参数就能看到每一行的执行细节？**
