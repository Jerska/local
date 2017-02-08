#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sf $DIR/.profile $HOME/.profile
ln -sf $DIR/.dir_colors $HOME/.dir_colors
ln -sf $DIR/.bashrc $HOME/.bashrc
ln -sf $DIR/.zshrc $HOME/.zshrc
ln -sf $DIR/.zpreztorc $HOME/.zpreztorc

# If you've installed prezto, those files are useless
rm -f ~/.zlogin
rm -f ~/.zlogout
rm -f ~/.zprofile
