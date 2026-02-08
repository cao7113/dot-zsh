# mktemp

```
mktemp /tmp/sops-test.XXXXXX
在 mktemp 命令中，末尾连续的 X 是占位符（Placeholders）。它们告诉操作系统：“请在这里填入随机字符，以确保生成的文件名是唯一的。”
具体规则
随机化：每一个 X 都会被替换为一个随机的字母或数字。

数量要求：在大多数系统（如 Linux/GNU）中，你必须至少提供 3 个 X。通常建议使用 6 个 或更多，以降低文件名碰撞的概率并增强安全性。

原子性创建：mktemp 不仅仅是生成一个名字，它还会真正地创建这个文件并设置严格的权限（通常是 600，即只有你自己能读写），这一切都是原子操作，防止了“竞态条件”（Race Condition）攻击。


创建临时目录
如果你需要存放一堆临时文件，可以加 -d 参数创建一个随机目录：

Bash
MY_TMP_DIR=$(mktemp -d /tmp/test-dir.XXXXXX)
# 之后所有的操作都在 $MY_TMP_DIR 下进行
带有后缀的随机名
有些工具需要文件带特定后缀（比如 .yaml），你可以用 --suffix：

Bash
mktemp /tmp/config.XXXXXX --suffix .yaml
# 输出可能是：/tmp/config.k7S2a1.yaml
```
