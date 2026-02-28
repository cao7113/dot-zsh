# list plugins here

# gitignore tmux
plugins=(
  git 
  sudo
  zoxide
  fzf
  mise 
  direnv 
  vscode
)
# zsh-interactive-cd

alias plug="omz-plugin"
function omz-plugin(){
  local act=${1:-ls}
  (( $# > 0 )) && shift

  local this_script="${${(%):-%x}:A}"

  case $act in
    vi)
      vi +4 $this_script
      dsh reload
      ;;
    a|all)
      # ls -ld $ZSH/plugins/*
      omz plugin list
      ;;
    l|ls)
      # echo $plugins
      omz plugin list --enabled
      ;;
    view|show)
      omz-get-plugin $@
      ;;
    *)
      # omz plug info git
      omz plugin $act "$@"
      ;;
  esac
}

function omz-get-plugin(){
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
