#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sf $DIR/.asdfrc $HOME/.asdfrc
ln -sf $DIR/.tool-versions $HOME/.tool-versions

ln -sf $DIR/.default-npm-packages $HOME/.default-npm-packages
ln -sf $DIR/.default-python-packages $HOME/.default-python-packages
ln -sf $DIR/.default-gems $HOME/.default-gems
