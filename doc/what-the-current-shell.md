# Which shell currently used?

在安装了 iTerm2 的 macOS 中，确定你正在使用的 Shell 类型非常简单。你可以通过以下几种命令和设置界面来进行验证。

### 1. 快速命令查看（推荐）

打开 iTerm2，输入以下任一命令：

- **查看当前运行的进程名（最准）**：

```bash
echo $0

```

如果是 Zsh，会输出 `-zsh`；如果是 Bash，会输出 `-bash`。

- **查看系统默认 Shell 路径**：

```bash
echo $SHELL

```

这会显示你的账号默认登录时加载的 Shell（例如 `/bin/zsh`）。注意，有时你可能在当前窗口临时切换了 Shell，这个变量可能不会立即改变。

- **查看系统已安装的所有 Shell 列表**：

```bash
cat /etc/shells

```

---

### 2. 通过 iTerm2 界面查看

iTerm2 的强大之处在于它可以为不同的 **Profiles（配置方案）** 设置不同的 Shell。

1. 按下快捷键 `Command (⌘)` + `i`（或者点击菜单栏 **iTerm2 -> Settings -> Profiles**）。
2. 在左侧选择你正在使用的 Profile（通常是 **Default**）。
3. 点击右侧的 **General** 标签页。
4. 找到 **Command** 这一栏：

- 如果选中的是 **Login Shell**：说明它使用的是系统默认的 Shell（macOS 10.15+ 默认为 Zsh）。
- 如果选中的是 **Command** 或 **Custom Shell**：后面输入框里的路径就是该 Profile 强制启动的 Shell。

---

### 3. 如何更改 iTerm2 的默认 Shell？

如果你想把 Zsh 换成 Bash，或者换成你新安装的 Fish：

- **方案 A：更改系统全局默认（所有终端生效）**

```bash
# 换成 zsh
chsh -s /bin/zsh
# 换成 bash
chsh -s /bin/bash

```

- **方案 B：仅更改 iTerm2 该配置文件的 Shell**
  在上面提到的 **Profiles -> General -> Command** 中，选择 **Command**，然后填入路径，例如 `/usr/local/bin/fish`。

---

### 💡 小贴士：如何判断是否配置成功？

观察你的**提示符（Prompt）**：

- **Zsh**：默认通常以 `%` 结尾。
- **Bash**：默认通常以 `$` 结尾。
- **Fish**：通常自带非常华丽的颜色，且提示符会根据当前文件夹显示。

**既然你已经确认了 Shell 类型，需要我帮你看看如何针对你的 Shell 安装像 `oh-my-zsh` 或 `pure` 这样能极大提升颜值和效率的插件吗？**
