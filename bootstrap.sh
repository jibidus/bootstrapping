#!/bin/bash -e

/usr/bin/ruby bootstrap.rb

# Git Config
mkdir -p ~/Development
cd ~/Development
git clone git@github.com:jibidus/dotfiles.git
ln -s ~/Development/dotfiles/.gitconfig ~/.gitconfig

# TODO See https://github.com/eduncan911/dotfiles
# TODO COMPLETE with https://github.com/lra/mackup
# TODO Manage retry
# TODO Install apps from AppStore

echo "Configure iTerm2 like this: https://gist.github.com/kevin-smets/8568070"