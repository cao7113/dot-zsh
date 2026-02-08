# Timing

在 Zsh 调试和性能优化中，`$EPOCHREALTIME` 是一个非常关键的内置变量。

### 1. 它是做什么的？

`$EPOCHREALTIME` 返回自 **Unix 纪元**（1970-01-01 00:00:00 UTC）以来的秒数，它的精度达到了 **微秒（Microseconds）**。

- **格式**：它是一个浮点数，例如 `1738852474.123456`。
- **加载方式**：它属于 `zsh/datetime` 模块。如果你直接使用报错或为空，需要先加载模块：

```zsh
zmodload zsh/datetime

```

---

### 2. 为什么调试时用它，而不是用 `date`？

在 Shell 脚本中，性能测试最忌讳的就是“测量工具本身太重”。

| 特性       | `date +%s%N`                 | `$EPOCHREALTIME`          |
| ---------- | ---------------------------- | ------------------------- |
| **开销**   | **高** (需要分叉子进程 fork) | **极低** (Zsh 内置变量)   |
| **精度**   | 纳秒级 (取决于系统)          | 微秒级 (足够脚本性能分析) |
| **易用性** | 需要外部命令                 | 像普通变量一样读取        |

---

### 3. 实战：如何用它精准测量函数耗时？

在你之前的 `source_dir_files` 函数中，我们就是利用它来标记“慢启动”脚本的。最标准的写法如下：

```zsh
zmodload zsh/datetime

local start_time=$EPOCHREALTIME

# 执行你要测试的代码
source ~/.zshrc

local end_time=$EPOCHREALTIME
# 计算差值 (Zsh 支持浮点运算)
local duration=$(( end_time - start_time ))

# 转换成毫秒显示
printf "执行耗时: %.3f ms\n" $(( duration * 1000 ))

```

---

### 4. 进阶技巧：配合 `zsh/mathfunc`

如果你想进行更复杂的统计（比如计算多次运行的平均耗时），可以配合数学函数模块：

```zsh
zmodload zsh/mathfunc
# 现在你可以使用 ceil(), floor(), sin(), cos() 等函数处理耗时数据

```

### 5. 注意事项：浮点数精度

Zsh 默认的浮点数输出可能会受 `PRECISION` 变量影响。如果你发现输出的位数不够，可以设置：

```zsh
typeset -F 6  # 强制浮点数保留 6 位小数

```

---

### 总结

在你的 `tools` 加载框架里，`$EPOCHREALTIME` 是做**防腐（防止配置变臃肿）**的最佳工具。你可以为每一个 source 的文件加上这个监控，一旦发现哪个 `rc.zsh` 超过了 **5ms**，就立刻通过 `DEBUG` 模式抓出来。

**你想让我帮你写一个装饰器函数，只需把任何命令传给它，它就能自动输出精确到微秒的耗时吗？**
