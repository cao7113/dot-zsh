# How ZSH_CUSTOM works?

在 Oh My Zsh (OMZ) 的生态中，`$ZSH_CUSTOM` 是一个非常精巧的设计，它允许用户在不修改 OMZ 核心源码的前提下，覆盖（Override）或扩展功能。

### 1. Oh My Zsh 中 `$ZSH_CUSTOM` 的工作原理

OMZ 的初始化脚本（`oh-my-zsh.sh`）会按照预定的顺序扫描目录。默认情况下，`$ZSH_CUSTOM` 指向 `~/.oh-my-zsh/custom`。

它的加载逻辑遵循 **“自定义优先”** 原则：

- **插件覆盖**：如果你在 `custom/plugins/git/git.plugin.zsh` 写了代码，OMZ 会优先加载它，而不是官方的 git 插件。
- **自动加载 (Auto-load)**：任何存放在 `custom/` 目录下且以 `.zsh` 结尾的文件，都会在 OMZ 启动时被**自动遍历并 source**。
- **主题存放**：`custom/themes/` 里的 `.zsh-theme` 文件可以被 `ZSH_THEME` 变量直接调用。

---

### 2. 在仅用 Antidote 的情况下如何支持？

当你转向 Antidote 时，你已经抛弃了 OMZ 的那套 `oh-my-zsh.sh` 加载引擎。Antidote 本身只负责“下载”和“静态加载”你在 `plugins.txt` 中指定的路径，**它不会主动去扫描你的 custom 目录**。

要在 Antidote 体系下实现类似 `$ZSH_CUSTOM` 的功能，你需要手动模拟这种“自动遍历”逻辑。

#### 方案一：在 `_core.zsh` 中手动模拟（推荐）

既然你已经有了 `_DSHRC_DIR` 路径，你可以建立一个 `custom` 文件夹，并在加载插件前后手动 source 它们。

在你的 `_core.zsh` 或 `raw.zsh` 中加入：

```zsh
# 定义你的自定义目录
readonly DSH_CUSTOM="$_DSHRC_DIR/custom"

# 1. 自动加载 custom 下的所有 .zsh 文件 (模拟 OMZ 的自动加载)
# (N) 标志表示如果目录为空，不报错
for custom_file in "$DSH_CUSTOM"/*.zsh(N); do
  source "$custom_file"
done

# 2. 如果你想覆盖 Antidote 加载的插件逻辑
# 确保在 source "$zsh_plugins_sh" 之后加载覆盖脚本

```

#### 方案二：将本地 Custom 路径直接加入 Antidote 清单

Antidote 支持加载本地路径。你可以把你的自定义插件或补全当作一个本地包来管理。

在你的 `plugins.txt` 中：

```text
# 加载 GitHub 插件
zsh-users/zsh-autosuggestions

# 加载本地自定义目录 (Antidote 会处理该目录下的 .zsh 文件)
/Users/rj/dev/ops/dot-zsh/zshrc/custom

```

---

### 3. 如何实现 OMZ 风格的“插件覆盖”？

在 OMZ 中，它是通过 `if [ -f $ZSH_CUSTOM/... ]` 这种复杂的判断实现的。但在 Antidote 这种“极简主义”架构下，我们通常使用 **Shell 函数重定义** 的特性：

1. 先让 Antidote 加载官方插件（例如 `ohmyzsh/ohmyzsh path:plugins/git`）。
2. 在你的 `custom/my_fixes.zsh` 中重新定义同名函数。
3. 因为后定义的函数会覆盖先定义的，从而达到“覆盖”的效果。

---

### 4. 最佳实践设计

为了保持你目前架构的优雅，建议按照以下目录结构组织：

```text
dot-zsh/
├── zshrc/
│   ├── raw.zsh       # 入口
│   ├── _core.zsh     # 补全与基础设置
│   ├── antidote.zsh  # Antidote 加载逻辑
│   └── custom/       # 你的 $ZSH_CUSTOM
│       ├── aliases.zsh
│       ├── env.zsh
│       └── git_override.zsh

```

**在 `_core.zsh` 的末尾添加：**

```zsh
# 模拟 OMZ 自定义功能
if [[ -d "$_DSHRC_DIR/custom" ]]; then
  for f in "$_DSHRC_DIR/custom"/*.zsh(N); do
    source "$f"
  done
fi

```

### 💡 总结

在 Antidote 体系下，不需要去维护一个复杂的 `ZSH_CUSTOM` 变量，**直接利用 Zsh 的 `for` 循环遍历目录执行 `source` 是最透明、最快的方式。** 需要我帮你写一个更高级的加载器，让它能像 OMZ 一样区分 `plugins`、`themes` 和 `lib` 的加载顺序吗？
