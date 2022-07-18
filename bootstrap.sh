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
# TODO Install apps from AppStore
# TODO Install asdf automatically + plugins

echo "- Configure iTerm2 like this: https://gist.github.com/kevin-smets/8568070"
echo "- Install Dbeaver Community Edition manually: https://dbeaver.io/download/"
echo "- Install asdf: https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies"
echo "- Install asdf plugin in ~/.zshrc"
echo "- Install docker: https://www.docker.com/get-started/"
echo "- Install other oh-my-zsh plugins: https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins"
echo "- Configure Homebrew completions: https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh"