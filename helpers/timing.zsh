function timestamp(){
  date +%s
}
function utime(){
  date +%s
}
function compact_time(){
  date "+%Y%m%d%H%M%S"
}
function number_time(){
  date "+%Y%m%d%H%M%S"
}
# htime
function human_time(){
  date "+%Y-%m-%d %H:%M:%S"
}
function db_time(){
  date "+%Y-%m-%d %H:%M:%S"
}

function human_date(){
  date "+%Y-%m-%d"
}
function current_date(){
  date "+%Y-%m-%d"
}
#$1: standard time string
function parse_time(){
  date --date $1 +%s
}

# date -r $(date +%s)
alias htime="date '+%Y-%m-%dT%H-%M-%S'"
alias nowTs="date +%s"
function parseTs(){
  date -r $@
}
