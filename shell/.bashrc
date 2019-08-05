# GSuite SDK {
  # The next line updates PATH for the Google Cloud SDK.
  if [ -f '/Users/jerska/local/google-cloud-sdk/path.bash.inc' ]; then source '/Users/jerska/local/google-cloud-sdk/path.bash.inc'; fi

  # The next line enables shell command completion for gcloud.
  if [ -f '/Users/jerska/local/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/jerska/local/google-cloud-sdk/completion.bash.inc'; fi
# }

# FZF {
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
# }

source $HOME/.profile
