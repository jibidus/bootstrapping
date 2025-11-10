#!/bin/bash -e

# Upgrade Homebrew
brew update
brew upgrade
brew cleanup

# Install ruby requirements (open3 gem)
brew install ruby
gem install open3

/usr/bin/ruby bootstrap.rb

# TODO See https://github.com/eduncan911/dotfiles
# TODO COMPLETE with https://github.com/lra/mackup
# TODO Manage retry
# TODO Make script runnable multiple times
# TODO Register new github ssh key and clone dotfiles and bootstrapping repositories with it
