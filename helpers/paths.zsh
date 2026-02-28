## command search path

## $path builtin bind to $PATH
# path=(path1 $paths) # prepend path
# path+=path1         # append path

alias paths='show_paths'

function show_paths() {
  local i=1
  local color1="cyan"
  local color2="blue"
  local current_color

  for p in $path; do
    # 逻辑：奇偶行交替颜色
    (( i % 2 == 0 )) && current_color=$color1 || current_color=$color2
    
    # %F: 开始颜色, %f: 结束颜色, %B: 加粗
    # %3d: 序号占3位且右对齐
    printf "%3d " $i
    print -P "%F{$current_color}%B$p%b%f"
    
    ((i++))
  done
}

function fpaths(){
  print -l $fpath
  # print -l $FPATH
}
