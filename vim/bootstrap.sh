#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p $HOME/.vim
ln -sf $DIR/.vimrc $HOME/.vimrc
ln -sf $DIR/.vimrc.plugs $HOME/.vimrc.plugs

mkdir -p ~/.config/nvim
ln -sf $HOME/.vimrc $HOME/.config/nvim/init.vim

vim +PlugInstall!
nvim +PlugInstall!
