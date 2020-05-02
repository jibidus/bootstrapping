#!/bin/bash -eu

echo "Update all dev stuff like homebrew, oh-my-zsh…"
echo "----------------------------------------------"

# Homebrew
brew upgrade
brew cleanup

# Zsh & co
upgrade_oh_my_zsh
cd ${ZSH_CUSTOM}/themes/powerlevel10k && git pull --rebase
cd ${ZSH_CUSTOM}/plugins/zsh-autosuggestions && git pull --rebase

# nvm
#curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# Need to update manually the link :(

# List of all pending Homebrew cask updates
./brew-cask.sh

echo ""
echo "Install manualy oh-my-zsh stuff (https://gist.github.com/kevin-smets/8568070)"
