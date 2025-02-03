#!/bin/bash -eu

echo "Update all dev stuff like asdf, homebrew…"
echo "----------------------------------------------"

asdf plugin update --all
brew update
brew upgrade
brew upgrade --cask
brew cleanup

echo "Update finished successfully!"