#!/bin/bash -e

# TODO Install Ruby with rbenv

# TODO Execute ruby
ruby bootstrap.rb

# Git Config
mkdir ~/Development/Perso
cd ~/Development/Perso
git clone git@github.com:jibidus/git-config.git
cd git-config
ln -s ~/Development/Perso/git-config/.gitconfig ~/.gitconfig

# TODO See https://github.com/eduncan911/dotfiles
# TODO COMPLETE with https://github.com/lra/mackup
# TODO Manage retry
# TODO Install apps from AppStore
