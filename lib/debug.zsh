# debug utils

function debug(){
  local act=${1:-"yes"}
  case $act in 
    n|no|off)
      unset DEBUG
      echo "# unset DEBUG"
      ;;
    y|yes|on)
      export DEBUG=${2:-1}
      echo "# set DEBUG=$DEBUG"
      ;;
    i|info)
      echo "# export DEBUG=$DEBUG"
      ;;
    *)
      echo "# export DEBUG=$DEBUG"
      echo "Usage: debug [on|off]"
      ;;
  esac
}

function dry(){
  local act=${1:-"yes"}
  case $act in 
    n|no|off)
      unset DRY
      echo "# unset DRY"
      ;;
    y|yes|on)
      export DRY=1
      # export DRY_RUN=1
      echo "# export DRY=$DRY"
      ;;
    i|info)
      echo "# export DRY=$DRY"
      ;;
    *)
      echo "# export DRY=$DRY"
      echo "Usage: dry [on|off]"
      ;;
  esac
}
