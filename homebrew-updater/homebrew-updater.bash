#!/bin/bash
# This script will update homebrew
# This script is part of Bootstraping project (see http://github.com/jibidus/bootstrapping)
set -u -e

echo ""
echo "$(date) --- New execution of homebrew-updater"

exit 0

brew update
brew upgrade
brew cleanup
brew doctor

exit 0
