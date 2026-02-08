## Profile with antidote plugins manager

## pre-setup

## load antidote rc
zstyle ':antidote:bundle' use-friendly-names 'yes'
export ANTIDOTE_HOME=$_DSH_PROFILE_DIR/_local/cache

# tmp fix for omz mise plugin( todo brew install alreay install completion to /opt/homebrew/share/zsh/site-functions)
export ZSH_CACHE_DIR=$ANTIDOTE_HOME
mkdir -p $ZSH_CACHE_DIR/completions

source $_DSH_PROFILE_DIR/.zshrc

## post-setup

function ant(){
  local act=$1
  case $act in 
    r|refresh|reload)
      echo "## Updating plugins: $zsh_plugins_sh ..."
      # rm -f "$zsh_plugins_sh"
      touch "$zsh_plugins_txt"
      dsh reload
      ;;
    p|plugin|plugins)
      # use ant install abc instead???
      echo "## Antidote plugins zsh: $zsh_plugins_sh ..."
      vi  "$zsh_plugins_txt"
      ;;
    l|ls)
      antidote list
      ;;
    cache)
      antidote home
      ;;
    up)
      antidote update
      ;;
    h)
      antidote help
      ;;
    *)
      antidote "$@"
      ;;
  esac
}

# 模拟 OMZ 自定义功能 todo put in plugins.txt
load_helpers