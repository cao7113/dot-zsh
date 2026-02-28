# NOTE: this file soft-linked by ~/.zshrc

if (( ! ${+_DSHRC_FILE} )); then
  # 拿到当前脚本的绝对路径 (处理了软链接展开) :A 含义：将路径转换为绝对路径并解析软链接 (Absolute)
  readonly _DSHRC_FILE="${${(%):-%x}:A}"
  readonly _DSHRC_DIR="${_DSHRC_FILE:h}"
  export readonly DSH_HOME="${_DSHRC_DIR}"

  source "${DSH_HOME}/lib/_dsh.zsh"
  source "${DSH_HOME}/lib/debug.zsh"
  source "${DSH_HOME}/lib/sourcer.zsh"
  source "${DSH_HOME}/lib/dotrc.zsh"
  source "${DSH_HOME}/alias.zsh"

  path=("${DSH_HOME}/bin" $path)

  # setopt EXTENDED_GLOB
  # fpath=("${DSH_HOME}/functions" $fpath)
  # for func in "${DSH_HOME}/functions"/*(N.:t); do
  #     autoload -Uz "$func"
  # done

  # 1. 必须开启扩展通配符
  setopt EXTENDED_GLOB

  fpath=("${DSH_HOME}/functions" $fpath)

  # 2. ^*.md 表示匹配所有文件，但排除以 .md 结尾的文件
  # (N.:t) 含义：N (找不到时不报错), . (只匹配普通文件), :t (只取文件名)
  for func in "${DSH_HOME}/functions"/^*.md(N.:t); do
      autoload -Uz "$func"
  done
fi

checkout_profile
dotrc load_dots