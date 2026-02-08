# alias root="sudo su"

function user_name(){
  #other methods: `whoami`; echo $USER
  id -un
}
function group_name(){
  id -gn
}
function all_groups(){
  id -Gn
}