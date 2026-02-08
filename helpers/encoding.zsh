alias randstr="cat /dev/urandom | env LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1"

# Purpose: translate upcase chars to lower
# Arguments:
#   $1: string to convert to lower case
function downcase(){
  echo $(tr '[A-Z]' '[a-z]'<<<"$@")
}

function upcase(){
  echo $(tr '[a-z]' '[A-Z]'<<<"$@")
}

function lower(){
  echo "$@" | tr '[:upper:]' '[:lower:]'
  # echo "0xc41a6Ce1E045f9b0c9629b4c08518aee9D259aF2" | tr '[:upper:]' '[:lower:]'
}

# function num(){
#    n=$(echo "$1" | sed 's/0x//')
# 	echo "ibase=16;${n}" | bc
# }

# - head -c20 /dev/urandom | od -A n -t x2
# - echo -n hi | base64 | base64 -d
# - echo -n "hi" | base64 | tr '/+' '_-' | tr -d '='