# Colors {
  pur='\033[35m'
  cya='\033[36m'
  rst='\033[0m'
# }

# Functions {
  function_usages=''
  add_function () {
    name=$1
    args=$2
    desc=$3

    rpad () {
      str=$1
      pad='                                                          '
      padlength=60

      printf '%s' "$str"
      printf '%*.*s' 0 $((padlength - ${#str})) "$pad"
    }

    first=`rpad "${pur}${name}${rst} ${cya}${args}${rst} "`
    function_usages="${function_usages}${first}${desc}\n"
  }

  functions () {
    echo -e "$function_usages"
  }
# }

# ls {
  # Dircolors (see .dir_colors)
  eval `gdircolors $HOME/.dir_colors`

  # Aliases
  unalias gls >/dev/null 2>&1
  alias ls='gls -1 --color=auto --group-directories-first'
  alias ll='gls -lh --color=auto --group-directories-first'
  alias la='gls -lAh --color=auto --group-directories-first'
# }

# Vim {
  alias v='nvim'
  export EDITOR='nvim'
  export VISUAL='nvim'
# }

# Less {
  export PAGER='less'
  export LESS='-g -i -M -R -S -w -z-4'
# }

# Browser {
  if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER='open'
  fi
# }

# Travis {
  [ -f /Users/jerska/.travis/travis.sh ] && source /Users/jerska/.travis/travis.sh
# }

# Ruby {
  # RVM
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

  # Aliases
  alias ber='bundle exec rake'
  alias bec='bundle exec cap'
# }

# JavaScript {
  export NVM_DIR="$HOME/.nvm"
  source "/usr/local/opt/nvm/nvm.sh"
  export PATH="./node_modules/.bin/:$PATH"
# }

# Python {
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
# }

# RipGrep {
  alias rg='/usr/local/bin/rg'
# }

# FZF {
  export FZF_DEFAULT_COMMAND='ripgrep --files --hidden --follow --glob "!.git/*"'
# }

# Git {
  alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# }

# Heroku {
  alias heroku-rebuild="git commit --allow-empty -m 'empty commit' && git push heroku master && git reset HEAD~1 && git push -f heroku master"
# }

# Extraction {
  add_function ex filename 'extracts a file in almost any format'
  ex () {
    if [ -z "$1" ]; then
      functions
    else
      if [ -f $1 ] ; then
        folder=`echo $1 | awk -F . '{ print $1 }'`
        mkdir $folder
        cd $folder
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
      else
        echo "$1 - file does not exist"
      fi
    fi
  }
# }
