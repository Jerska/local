#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sf $DIR/.bashrc $HOME/.bashrc
ln -sf $DIR/.zshrc $HOME/.zshrc
ln -sf $DIR/.profile $HOME/.profile
ln -sf $DIR/.dir_colors $HOME/.dir_colors
