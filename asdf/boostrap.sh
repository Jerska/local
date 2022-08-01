#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sf $DIR/.asdfrc $HOME/.asdfrc
ln -sf $DIR/.tool-versions $HOME/.tool-versions

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add python https://github.com/danhper/asdf-python
asdf plugin add golang https://github.com/kennyp/asdf-golang
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git

ln -sf $DIR/.default-npm-packages $HOME/.default-npm-packages
ln -sf $DIR/.default-python-packages $HOME/.default-python-packages
ln -sf $DIR/.default-gems $HOME/.default-gems
