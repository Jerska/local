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
      pad=$(printf '%0.1s' " "{1..60})
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

# Ruby {
  # RVM
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

  # Aliases
  alias ber='bundle exec rake'
  alias bec='bundle exec cap'
# }

# Git {
  alias gitlog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
# }

# Extraction {
  add_function ex filename 'extracts a file in almost any format'
  ex () {
    if [ -z "$1" ]; then
      functions
    else
      if [ -f $1 ] ; then
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
