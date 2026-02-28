# NOTE: this file will be soft-linked by ~/.zshrc

if (( ! ${+_ZSHRC_FILE} )); then
  # 拿到当前脚本的绝对路径 (处理了软链接展开) :A 含义：将路径转换为绝对路径并解析软链接 (Absolute)
  readonly _ZSHRC_FILE="${${(%):-%x}:A}"
  readonly _ZSHRC_DIR="${_ZSHRC_FILE:h}"
  export readonly DSH_HOME="${_ZSHRC_DIR}"

  source "${DSH_HOME}/lib/_dsh.zsh"
  source "${DSH_HOME}/lib/debug.zsh"
  source "${DSH_HOME}/lib/sourcer.zsh"
  source "${DSH_HOME}/lib/dotrc.zsh"
  source "${DSH_HOME}/alias.zsh"

  # path+=("${DSH_HOME}/bin")
  path=("${DSH_HOME}/bin" $path)
fi

checkout_profile
dotrc load_dots