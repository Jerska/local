#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p $HOME/.vim
ln -sf $DIR/.vimrc $HOME/.vimrc
ln -sf $DIR/.vimrc.plugs $HOME/.vimrc.plugs

vim +PlugInstall
