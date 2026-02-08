# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zsh_plugins_txt="$_DSH_PROFILE_DIR/plugins.txt"
zsh_plugins_sh="$_DSH_PROFILE_DIR/_local/plugins.zsh"
antidote_repo_dir=$_DSH_PROFILE_DIR/_local/antidote
antidote_sh_path=$antidote_repo_dir/antidote.zsh

# Lazy-load antidote from its functions directory.
fpath=($antidote_repo_dir/functions $fpath)
autoload -Uz antidote

# 只有当 plugins.txt 更新时，Antidote 才会重新生成缓存文件
if [[ ! "$zsh_plugins_sh" -nt "$zsh_plugins_txt" ]]; then
  source "$antidote_sh_path"
  antidote bundle < "$zsh_plugins_txt" > "$zsh_plugins_sh"
fi

# 极速加载编译后的静态插件脚本
source "$zsh_plugins_sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh