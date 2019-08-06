# FZF {
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
# }

# GCloud SDK {
  GCSDK_PATH="$HOME/local/google-cloud-sdk"
  [ -f "$GCSDK_PATH/path.bash.inc" ] && source "$GCSDK_PATH/path.bash.inc"
  [ -f "$GCSDK_PATH/completion.bash.inc" ] && source "$GCSDK_PATH/completion.bash.inc"
# }

source $HOME/.profile
