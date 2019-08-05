# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Disable auto-correct
unsetopt correct
# Disable auto-name-dirs because it breaks the prompt
unsetopt AUTO_NAME_DIRS

# Remove weird prezto aliases
alias cp='nocorrect cp'
alias ln='nocorrect ln'
alias mv='nocorrect mv'
alias rm='nocorrect rm'
alias cpi="${aliases[cp]:-cp} -i"
alias lni="${aliases[ln]:-ln} -i"
alias mvi="${aliases[mv]:-mv} -i"
alias rmi="${aliases[rm]:-rm} -i"

# FZF {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }

# Source .profile
[[ -e $HOME/.profile ]] && source $HOME/.profile
