## preset

# use gnu ls instead of the default ls, check by: which -a ls
# https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#enable-gnu-ls-in-macos-and-freebsd-systems
zstyle ':omz:lib:theme-and-appearance' gnu-ls yes
# Note: this is not compatible with DISABLE_LS_COLORS=true

# use helpers
ZSH_CUSTOM=$DSH_HOME/helpers
# gitignore
plugins=(git direnv mise)

## source omz gengerated .zshrc # NOTE: keep .zshrc not modified as possible!!!
source $_DSH_PROFILE_DIR/.zshrc

## post customization

function omz-plugin(){
  local name=$1
  local pdir=$ZSH/plugins/$name
  if [ -d $pdir ]; then
    local pfile=$pdir/$name.plugin.zsh
    if [ -f $pfile ]; then
      cat $pfile
      echo
      echo "# plugin file: $pfile"
      echo "# plugin http: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/$name"
    else
      echo "Not found plugin file $pfile"
    fi
  else
    echo "Not found plugin $pdir"
  fi
}