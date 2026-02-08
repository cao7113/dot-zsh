
## zsh utils


function zsh_version() {
  zsh --version
  echo
  echo "which zsh:    $(which -a zsh)"
  echo "SHELL:        $SHELL"
  echo "ZSH_VERSION:  $ZSH_VERSION"
  echo "SHLVL:        $SHLVL"
  echo "ZSH:          $ZSH" # omz config
  # ps -p $$
}

function zsh_files() {
  ls -ld ~/.z*
}

function zsh_version_check() {
    echo "Checking for updates..."
    # 检查 brew 是否安装，且当前使用的是否为 brew 版 zsh
    [[ ! -x "$(command -v brew)" ]] && return
    [[ "$SHELL" != *"homebrew"* ]] && return

    local cache_file="${XDG_CACHE_HOME:-$HOME/.cache}/zsh_update_last_check"
    local today=$(date +%Y-%m-%d)

    # 每天只检查一次，避免频繁调用 brew 导致启动变慢
    if [[ ! -f "$cache_file" || "$(cat "$cache_file")" != "$today" ]]; then
        (
            # 在后台运行，不阻塞当前终端启动
            local latest_version=$(brew info zsh --json | jq -r '.[0].versions.stable' 2>/dev/null)
            local current_version=$ZSH_VERSION
            
            if [[ -n "$latest_version" && "$latest_version" != "$current_version" ]]; then
                echo -e "\n\033[1;33m[Update]\033[0m A new version of Zsh ($latest_version) is available!"
                echo -e "Current version: $ZSH_VERSION. Run \033[1;32mbrew upgrade zsh\033[0m to update.\n"
            fi
            # 更新检查日期
            mkdir -p "$(dirname "$cache_file")"
            echo "$today" > "$cache_file"
        ) &! # &! 表示在后台运行且不显示任务 ID
    fi
}

function zsh_clean_compdump(){
  # https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-reset-the-completion-cache
  # echo $ZSH_COMPDUMP

  ## completion with brew
  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
  # rm -f ~/.zcompdump; compinit
  # l $(brew --prefix)/share/zsh/site-functions
  
  # reset zcompinit cache
  rm -fr ~/.zcompdump*
  exec zsh -l
}