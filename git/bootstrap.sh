#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sf $DIR/.gitignore $HOME/.gitignore
ln -sf $DIR/.gitconfig $HOME/.gitconfig
