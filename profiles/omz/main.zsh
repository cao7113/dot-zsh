## preset

# use gnu ls instead of the default ls, check by: which -a ls
# https://github.com/ohmyzsh/ohmyzsh?tab=readme-ov-file#enable-gnu-ls-in-macos-and-freebsd-systems
zstyle ':omz:lib:theme-and-appearance' gnu-ls yes
# Note: this is not compatible with DISABLE_LS_COLORS=true

# use helpers
ZSH_CUSTOM=$DSH_HOME/helpers
# set plugins
source $_DSH_PROFILE_DIR/plugins.zsh

## source omz gengerated .zshrc # NOTE: keep .zshrc not modified as possible!!!
source $_DSH_PROFILE_DIR/.zshrc

## post customization
