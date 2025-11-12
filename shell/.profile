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
  export NODE_PATH="$(npm root -g)"
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

# Binutils {
  BINUTILS_DIR="${HOMEBREW_PREFIX}/opt/binutils"
  if [ -d "$BINUTILS_DIR" ]; then
    export PATH="$BINUTILS_DIR/bin:$PATH"
    export LDFLAGS="-L${BINUTILS_DIR}/lib"
    export CFLAGS="-I${BINUTILS_DIR}/include"
    export CPPFLAGS="-I${BINUTILS_DIR}/include"
  fi
# }

# Go {
  GO_VERSION="$(asdf current golang | awk '{ print $2 }' | tail -n 1)"
  export GOROOT="/Users/jerska/.asdf/installs/golang/$GO_VERSION/go" # Needed, otherwise gopls explodes
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
  if [ -f "${HOMEBREW_PREFIX}/bin/rg" ]; then
    alias rg="${HOMEBREW_PREFIX}/bin/rg"
  fi
# }

# Task
  if [ -d "${HOMEBREW_PREFIX}/Cellar" ] && [ -d "${HOMEBREW_PREFIX}/Cellar/task/" ]; then
    task_bin="$(echo "${HOMEBREW_PREFIX}/Cellar/task/"*"/bin/task")"
    alias t="$task_bin"
  fi

# FZF {
  export FZF_DEFAULT_COMMAND='ripgrep --files --hidden --follow --glob "!.git/*"'
# }

# Git {
  alias gps="git push -u"
  alias gpl="git pull"
  alias gst="git status"
  alias gcm="git commit"
  alias gco="git checkout"
  alias gdf="git diff"
  alias gdft="git difftool"
  alias grs="git restore --staged"
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

# Github {
  add_function ghkill '<repo> <runid>' 'Force kill github job'

  ghkill() {
    local repo="$1"
    local runid="$2"

    curl -X POST \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $(gh auth token)" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/${repo}/actions/runs/${runid}/force-cancel
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

  # From https://stackoverflow.com/a/73108928/1561269
  add_function dockersize path_to_img:tag 'get the size of a docker image'
  dockersize() {
    docker manifest inspect -v "$1" |
      jq -c 'if type == "array" then .[] else . end' |
      jq -r '[(
        .Descriptor.platform |
        [ .os, .architecture, .variant, ."os.version" ] |
        del(..|nulls) |
        join("/")
      ), (
        [ .SchemaV2Manifest.layers[].size ] | add
      )] | join(" ")' |
      numfmt --to iec --format '%.2f' --field 2 |
      column -t;
  }
# }

# Migrate machine {
  add_function migrate_send file_or_folder 'transmit file or folder over the network (needs migrate_recv on the receiver)'
  migrate_send() {
    local p="$1"

    if [[ -z "$p" ]]; then
      echo "Usage: migrate_send <file_or_folder>" >&2
      return 1
    fi
    if [[ -z "$MIGRATE_HOST" || -z "$MIGRATE_PORT" ]]; then
      echo "Error: MIGRATE_HOST and MIGRATE_PORT must be set." >&2
      return 1
    fi

    local abs_path abs_home relpath
    abs_path="$(cd "$(dirname "$p")" && pwd)/$(basename "$p")"
    abs_home="$(cd "$HOME" && pwd)"

    if [[ "$abs_path" == "$abs_home/"* ]]; then
      relpath="${abs_path#"$abs_home/"}"
    else
      relpath="$abs_path"
    fi

    echo "Sending '$relpath' to $MIGRATE_HOST:$MIGRATE_PORT ..." >&2
    tar -czf - -C "$HOME" "$relpath" | nc "$MIGRATE_HOST" "$MIGRATE_PORT"
    echo "✅ Sent '$relpath'." >&2
  }

  add_function migrate_recv '' 'opens a server to copy files from a remote machine (see migrate_send)'
  migrate_recv() {
    local port="1234"
    local myip=""

    # Try to auto-detect local IP (Linux/macOS compatible)
    myip="$(hostname -I 2>/dev/null | awk '{print $1}')"
    if [[ -z "$myip" ]]; then
      myip="$(ipconfig getifaddr en0 2>/dev/null)"
    fi

    if [[ -z "$myip" ]]; then
      myip="<could_not_be_found>"
      echo "⚠️  Warning: Could not determine local IP address automatically." >&2
      echo "   Replace <could_not_be_found> with your actual IP in the MIGRATE_HOST variable." >&2
    fi

    cat >&2 <<EOF
Ready to receive.

On the sender side, first set those two environment variables

export MIGRATE_HOST="$myip"
export MIGRATE_PORT="$port"

Then call \`migrate_send\` as many times as necessary:

migrate_send "<folder_or_file>"
migrate_send "<folder_or_file>"

Listening on port $port...

EOF

    while true; do
      nc -l "$port" | tar -xzf - -C "$HOME"
      echo "✅ Received and extracted archive. Waiting for next transfer..." >&2
      sleep 1
    done
  }
# }

# Kubernetes {
  alias k=kubectl
  alias kw=~/local/shell/kubewatch.sh
  alias kn=k9s
# }

# Rust {
  source "$HOME/.cargo/env"
# }

# ulimit {
  ulimit -n `ulimit -Hn` # Set soft limit of open fds to hard limit
# }

# Z {
  source "$HOME/local/shell/z.sh"
# }
