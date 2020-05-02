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

# List of all pending Homebrew cask updates
./brew-cask.sh

echo ""
echo "Remains to be installed manually:"
echo "- oh-my-zsh stuff (https://gist.github.com/kevin-smets/8568070)"
echo "- Node Version Manager (https://github.com/nvm-sh/nvm)"
