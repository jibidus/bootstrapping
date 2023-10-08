#!/bin/bash -e

# Upgrade Homebrew
brew update
brew upgrade
brew cleanup

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

# TODO See https://github.com/eduncan911/dotfiles
# TODO COMPLETE with https://github.com/lra/mackup
# TODO Manage retry
# TODO Make script runnable multiple times
# TODO Register new github ssh key and clone dotfiles and bootstrapping repositories with it
