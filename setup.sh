#! /bin/zsh
set -e 
# set -x

# https://github.com/Homebrew/install
if which brew > /dev/null; then
  echo "brew already installed"
else
  echo "#### Start brew installing..."
  echo "https://docs.brew.sh/Installation#git-remote-mirroring"
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  #brew update
  echo "#### Brew installed"
fi

if which task > /dev/null; then
  echo "go-task already installed"
else
  # echo "install go-task by https://taskfile.dev"
  # brew install go-task/tap/go-task
  # https://taskfile.dev/installation/#homebrew
  brew install go-task
  echo "Task installed"
fi

echo "Congrats! Ready to go from Taskfile.yml!"