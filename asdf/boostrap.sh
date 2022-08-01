#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sf $DIR/.asdfrc $HOME/.asdfrc
ln -sf $DIR/.default-npm-packages $HOME/.default-npm-packages
