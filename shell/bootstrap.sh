#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ -f $DIR/.profile.private ] || cp $DIR/.profile.private.example $DIR/.profile.private

ln -sf $DIR/.profile $HOME/.profile
ln -sf $DIR/.profile.private $HOME/.profile.private
ln -sf $DIR/.dir_colors $HOME/.dir_colors
ln -sf $DIR/.bashrc $HOME/.bashrc
ln -sf $DIR/.zshrc $HOME/.zshrc
ln -sf $DIR/.zpreztorc $HOME/.zpreztorc
ln -sf $DIR/.p10k.zsh $HOME/.p10k.zsh

# If you've installed prezto, those files are useless
rm -f ~/.zlogin
rm -f ~/.zlogout
rm -f ~/.zprofile

echo
echo "You need to:"
echo "  - fill local/shell/.profile.private"
echo "  - clone powerlevel10k in local/"
