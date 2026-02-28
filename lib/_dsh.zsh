readonly DOT_ZSHRC=~/.zshrc
readonly DSH_DOT_PROFILE_FILE=~/.zshrc_profile
readonly DSH_DOTRC_HOME=~/.zsh_dots

# 定义全局关联数组 -g 代表全局，-A 代表关联数组
typeset -gA DSH_PROFILE_ALIASES
readonly DSH_PROFILE_ALIASES=(
  a "ant"
  o "omz"
  b "bare"
  p "play"
)

function dsh(){
  local act=$1
  case $act in
    i|info)
      dsh_info
      ;;
    u|use|switch)
      shift
      dsh_use_profile "$@"
      dsh_reload
      ;;
    p|profile)
      echo $_DSH_PROFILE_RC
      ;;
    pcd)
      shift 
      if [[ -z "$1" ]]; then
        cd ${_DSH_PROFILE_RC:h}
      else
        cd $DSH_HOME/profiles/$1
      fi
      ;;
    o|omz)
      dsh pcd omz
      ;;
    r|up|reload)
      dsh_reload
      ;;
    clean)
      zsh_clean_compdump
      ;;
    core)
      local core_file="${${(%):-%x}:A}"
      echo "# core_file: $core_file"
      ;;
    l|ls|files)
      zsh_files
      ;;
    home)
      echo $DSH_HOME
      ;;
    ohome)
      echo $ZSH
      ;;
    v|version)
      zsh_info
      ;;
    *)
      cd $DSH_HOME
      ;;
  esac
}

function dsh_info() {
  cat <<-EOF
## Dsh info with zsh profile

# DSH_HOME          =   $DSH_HOME
# _ZSHRC_FILE       =   $_ZSHRC_FILE
# _DSH_PROFILE_RC   =   $_DSH_PROFILE_RC
# _DSH_PROFILE_DIR  =   $_DSH_PROFILE_DIR
EOF
}

function dsh_reload() {
  # like omz reload 
  exec zsh -l
}

function dsh_use_profile() {
  local profile_id=$1
  
  # 如果未输入参数，显示可用列表
  if [[ -z "$profile_id" ]]; then
    echo "Usage: dsh_use_profile <ID>"
    echo "available profiles: ${(kv)DSH_PROFILE_ALIASES}"
    return 1
  fi

  # 检查是否命中别名，命中则转换
  if (( ${+DSH_PROFILE_ALIASES[$profile_id]} )); then
    profile_id=${DSH_PROFILE_ALIASES[$profile_id]}
  fi

  local profile_rc="${DSH_HOME}/profiles/${profile_id}/main.zsh"

  if [[ -f "$profile_rc" ]]; then
    ln -sf "$profile_rc" $DSH_DOT_PROFILE_FILE
    echo -e "✅ Switched profile: \e[1;32m$profile_id\e[0m, new session to take effect! "
  else
    echo -e "❌ Not found $profile_rc "
    return 1
  fi
}

# # 编写补全脚本
# function _dsh_use_profile_comp() {
#   # 获取关联数组的所有键值对
#   # 使用 (kv) 展开，使得补全菜单显示 "a -- ant" 这种说明格式
#   local -A choices
#   choices=("(${(kv)DSH_PROFILE_ALIASES})")
  
#   # _describe 用于生成带说明的补全列表
#   _describe 'DSH Profiles' choices
# }

# 注册补全
# compdef _dsh_use_profile_comp dsh_use_profile

function checkout_profile(){
    local _profile_link=$DSH_DOT_PROFILE_FILE

    if [[ -e "$_profile_link" ]]; then
        _DSH_PROFILE_RC="${_profile_link:A}"
        _DSH_PROFILE_DIR="${_DSH_PROFILE_RC:h}"
        source "$_DSH_PROFILE_RC"
    elif [[ -L "$_profile_link" ]]; then
        echo "[dsh] Warning: Profile link is BROKEN. Target missing: ${_profile_link:A}"
    else
        echo "[dsh] No profile link: $_profile_link"
        echo "run: dsh profile [bare|ant|omz]"
    fi
}

function load_helpers() {
  local helpers_home=${1:-$DSH_HOME/helpers}
  source_dir_files $helpers_home "*.zsh"
}
