#!/bin/bash -e

# Install ruby requirements (open3 gem)
brew install rbenv ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zprofile
echo 'eval "$(rbenv init -)"' >> ~/.zprofile
source ~/.zprofile
rbenv install 2.6.8
rbenv global 2.6.8
rbenv rehash
gem install open3

/usr/bin/ruby bootstrap.rb

# Git Config
mkdir -p ~/Development
cd ~/Development
git clone git@github.com:jibidus/dotfiles.git
ln -s ~/Development/dotfiles/.gitconfig ~/.gitconfig

# TODO See https://github.com/eduncan911/dotfiles
# TODO COMPLETE with https://github.com/lra/mackup
# TODO Manage retry
# TODO Make script runnable multiple times
