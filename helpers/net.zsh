alias ports="sudo netstat -lnput"

function netspeed() {
  url=${1:-http://mirrors.163.com/ubuntu-releases/18.04/ubuntu-18.04.4-desktop-amd64.iso}
  curl $url >/dev/null
}

#get specified interface's ip address
# $1: specified interface, e.g. wlan0, lo, eth0
# return string, e.g. 127.0.0.1
function host_ip(){
  iface=${1:-en0} # eth0
  ifconfig $iface | grep -o 'inet [^ ]*' | awk '{print $2}'
}
# export -f host_ip


## ops
# dig telnet non interactive
# nc -zv zkfair.test.ip 5672

alias sshv="command ssh -v"
alias hctl=hostctl

alias myip="publicip"
alias lip=ip
function ip(){
  iface=${1:-en0}
  echo "#iface: $iface ip"
  ipconfig getifaddr $iface
}

function ports(){
  case $OSTYPE in
    darwin*)
      #sudo lsof -nPi TCP | sort -k9
      #sudo lsof -nPi TCP | { read -r header; echo "$header"; sort -k9; }
      #sudo lsof -nPi TCP | tail -n +2 | sort -k9
      sudo lsof -nPi TCP | awk 'NR>1' | sort -k9
      ;;
    *)
      # on ubuntu
      # sudo apt install net-tools
      sudo netstat -lnput
      ;;
  esac

  #<<Note
  #    sudo lsof -nP -iTCP:端口号 -sTCP:LISTEN
  #    -n 表示不显示主机名
  #    -P 表示不显示端口俗称
  #    不加 sudo 只能查看以当前用户运行的程序
  #
  #    lsof -nP -iTCP:4000 |grep LISTEN|awk '{print $2;}'
  #    输出占用该端口的 PID
  #Note
}

# function localip(){
#   iname=${1:-ens5}
#   ifconfig $iname | awk '/inet / {print $2}'
# }

# function set_hostname(){
#   [ $# -lt 1 ] && echo "require _hostname_" && return 1
#   newname=$1
#   sudo echo $newname > /etc/hostname
#   sudo echo "127.0.0.1 $newname" >> /etc/hosts && echo 永久设置hostname  #TODO use sed?
#   echo Reboot to take effect! #sudo reboot
# }
