#!/bin/sh
set -u -e

echo "This script will install or upgrade homebrew-updater launchd agent to current user."
echo "This agent will upgrade Homebrew every day at 1:00pm if internet connection is active."

agent_id=com.jibidus.homebrew-updater
plist_filename=com.jibidus.homebrew-updater.plist
script_filename=homebrew-updater.bash

agents_folder=$HOME/Library/LaunchAgents
scripts_folder=$HOME/Library/Scripts/homebrew-updater

if [ ! $(launchctl list | grep -cF $agent_id) -eq 0 ]; then
	echo "Agent already running. Stopping agent..."
	launchctl unload $agents_folder/$plist_filename
fi

echo "Installing script..."
[ -d $scripts_folder ] || mkdir -p $scripts_folder
cp $script_filename $scripts_folder/$script_filename

echo "Installing agent..."
[ -d $agents_folder ] || mkdir -p $agents_folder
cp $plist_filename $agents_folder/$plist_filename

echo "Configuring agent..."
sed -i "" -e "s#\${script_folder}#$scripts_folder#g" $agents_folder/$plist_filename

echo "Starting agent..."
launchctl load $agents_folder/$plist_filename

echo "Homebrew-updater successfully installed."
echo "Agent's logs will be available here:"
echo "- /var/log/homebrew-updater.log"
echo "- /var/log/homebrew-updater.error.log"
