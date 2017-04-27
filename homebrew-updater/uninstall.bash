#!/bin/sh
set -u -e

plist_filename=com.jibidus.homebrew-updater.plist
script_filename=homebrew-updater.bash

agents_folder=$HOME/Library/LaunchAgents
scripts_folder=$HOME/Library/Scripts/homebrew-updater

launchctl unload $agents_folder/$plist_filename
rm -Rf $scripts_folder
rm $agents_folder/$plist_filename

echo "Homebrew-updater successfully removed."
