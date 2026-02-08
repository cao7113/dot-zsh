
## dot-rcs linking

function dotrc() {
  local act=$1
  mkdir -p $DSH_DOTRC_HOME
  case $act in 
    where)
      echo "HOME: $DSH_DOTRC_HOME"
      ;;
    ln|link)
      shift
      if [[ $# -eq 0 ]];then
        echo "Usage: dotrc ln <file> [<link_name>]"
        return 1
      fi
      local src_file=${1:A}
      local ln_name=${2:-"${src_file:h:t}-${src_file:t}"}
      local ln_file=$DSH_DOTRC_HOME/$ln_name
      echo "Linking $ln_file -> $src_file"
      ln -sf $src_file $ln_file
      ;;
    l|ls)
      ls -l $DSH_DOTRC_HOME
      ;;
    cd)
      cd $DSH_DOTRC_HOME
      ;;
    source|load_dots)
      DEPTH=0 source_dir_files $DSH_DOTRC_HOME "*.zsh"
      ;;
    *)
      cd $DSH_DOTRC_HOME
  esac
}