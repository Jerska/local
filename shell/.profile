# To profile what takes time, uncomment this and use
# set -x
# set +x
# around the code block you want to profile

# PS4='+ $(date "+%s.%N")\011 '
# exec 3>&2

set +o noclobber

# Local binaries {
  export PATH="$HOME/local/bin/:$PATH"
# }

# Locale {
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
# }

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

# Typos {
  alias sl=ls
  alias gh=fg
# }

# OSX {
  add_function sha256sum filename 'compute a sha256sum of the input file'
  sha256sum () {
    shasum -a 256 "$@"
  }
  if [ -d "/opt/homebrew" ]; then
    export HOMEBREW_PREFIX="/opt/homebrew"
    export PATH="${HOMEBREW_PREFIX}/bin:$PATH"
  else
    export HOMEBREW_PREFIX="/usr/local"
  fi
  export HOMEBREW_NO_AUTO_UPDATE=1
  export PATH="/usr/local:$PATH"
# }

# GPG {
  export GPG_TTY=$(tty)
# }

# ls {
  source "$HOME/local/shell/lscolors.sh"
  # Aliases
  unalias gls >/dev/null 2>&1
  ls_command="ls"
  if command -v gls >/dev/null 2>&1; then
    ls_command="gls"
  fi
  alias ls="$ls_command -1 --color=auto --group-directories-first"
  alias ll="$ls_command -lh --color=auto --group-directories-first"
  alias la="$ls_command -lAh --color=auto --group-directories-first"
# }

# Vim {
  v() {
    if command -v nvim >/dev/null 2>&1; then
      nvim "$@"
    else
      vim "$@"
    fi
  }
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

# asdf {
  alias qsdf="asdf"
  [ -f ${HOMEBREW_PREFIX}/opt/asdf/libexec/asdf.sh ] && source ${HOMEBREW_PREFIX}/opt/asdf/libexec/asdf.sh
# }

# JavaScript {
  export PATH="./node_modules/.bin/:$PATH"
  alias y="yarn"
# }

# Python {
  export PYTHON_BUILD_HOMEBREW_OPENSSL_FORMULA="openssl@3"
# }

# OpenSSL {
  OPENSSL_DIR="${HOMEBREW_PREFIX}/opt/openssl@3"
  if [ -d "$OPENSSL_DIR" ]; then
    export LDFLAGS="-L${OPENSSL_DIR}/lib $LDFLAGS"
    export CFLAGS="-I${OPENSSL_DIR}/include $CFLAGS"
    export CPPFLAGS="-I${OPENSSL_DIR}/include $CPPFLAGS"
  fi
# }

# Readline {
  READLINE_DIR="${HOMEBREW_PREFIX}/opt/readline"
  if [ -d "$READLINE_DIR" ]; then
    export LDFLAGS="-L${READLINE_DIR}/lib $LDFLAGS"
    export CFLAGS="-I${READLINE_DIR}/include $CFLAGS"
    export CPPFLAGS="-I${READLINE_DIR}/include $CPPFLAGS"
  fi
# }

# Curl {
  CURL_DIR="${HOMEBREW_PREFIX}/opt/curl"
  if [ -d "$CURL_DIR" ]; then
    export LDFLAGS="-L${CURL_DIR}/lib $LDFLAGS"
    export CFLAGS="-I${CURL_DIR}/include $CFLAGS"
    export CPPFLAGS="-I${CURL_DIR}/include $CPPFLAGS"
  fi
# }

# Go {
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
  export GO111MODULE=on
  export GOPROXY="https://proxy.golang.org,direct"
# }

# Salt {
  salt-ssh-func () (
    cd $HOME/code/salt && pyenv-exec py2 "salt-ssh" "$@"
  )
  alias salt-ssh="salt-ssh-func"
  alias salt="salt-ssh-func"
# }

# RipGrep {
  alias rg="${HOMEBREW_PREFIX}/bin/rg"
# }

# FZF {
  export FZF_DEFAULT_COMMAND='ripgrep --files --hidden --follow --glob "!.git/*"'
# }

# Git {
  alias gps="git push -u"
  alias gpl="git pull"
  alias gst="git status"
  alias gcm="git commit"
  alias gco="git checkout"
  alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

  # Prune
  add_function gprune '' 'prunes all branches that do not exist on remote'

  gtestprune() {
    git branch -vv | awk '/: gone]/{print $1}' | grep --color=never .
  }

  gprune () {
    echo 'Automatic prune'
    git fetch -p
    echo 'Those branches will be deleted'
    gtestprune
    echo -en '\nAre you sure? (y/N) '
    read yn
    if [[ "$yn" == "y" ]]; then
      gtestprune | xargs git branch -D
      echo 'Completed pruning'
      echo
      echo "Remaining branches"
      git --no-pager branch
    else
      echo 'Cancelled pruning'
    fi
  }
# }

# Heroku {
  alias heroku-rebuild="git commit --allow-empty -m 'empty commit' && git push heroku master && git reset HEAD~1 && git push -f heroku master"
# }

# Algolia {
  export PATH="$PATH:$HOME/algolia/bin"
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

# Ruby {
  # RVM
  export PATH="$PATH:$HOME/.rvm/bin"
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

  # Aliases
  alias ber='bundle exec rake'
  alias bec='bundle exec cap'
# }

# Private {
  source $HOME/.profile.private
# }

# Docker {
  alias dcup="docker-compose up"
# }

# Kubernetes {
  alias k=kubectl
  alias kw=~/local/shell/kubewatch.sh
  alias kn=k9s
# }

# Z {
  source "$HOME/local/shell/z.sh"
# }
