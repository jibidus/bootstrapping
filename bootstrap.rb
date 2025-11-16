#require_relative "traces.rb"
require_relative "support.rb"

additional_operations = AdditionalOperations.new

# Check prerequisites
# ---------------------------------------------------------
check_prerequisite 'brew', 'Homebrew'
check_prerequisite 'git', 'Git'

# Oh-my-zsh
# ---------------------------------------------------------
oh_my_zsh_home = File.join(Dir.home, ".oh-my-zsh")
unless Dir.exist?(oh_my_zsh_home)
  execute 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
end
additional_operations.add "Install other oh-my-zsh plugins:"
additional_operations.add " - https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md"
additional_operations.add " - https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md"
additional_operations.add "Automate oh-my-zsh-update: https://github.com/ohmyzsh/ohmyzsh"
additional_operations.add "Automate oh-my-zsh plugin updates: https://github.com/TamCore/autoupdate-oh-my-zsh-plugins"

# Git config
# ---------------------------------------------------------
global_gitignore = File.join(Dir.home, ".gitignore")
execute "git config --global core.excludesFile '#{global_gitignore}'"
execute("touch #{global_gitignore}")
ignored_pattern = ".DS_Store"
unless File.readlines(global_gitignore).any?{ |l| l[ignored_pattern] }
    append_text ignored_pattern, global_gitignore
end

# Brew formulas
# ---------------------------------------------------------

# trash files instead of 'rm' command
brew :install, 'trash'

# Github app to drive github from command line
brew :install, 'hub'

# Gradle
brew :install, 'gradle'

# Spring boot CLI
brew :tap, 'spring-io/tap'
brew :install, 'spring-boot'

# Better curl
brew :install, 'httpie'

# Mysql server and client
brew :install, 'mysql'

# AsciiDoc text document format manipulation (http://asciidoc.org)
brew :install, 'asciidoc'

# ftp, telnet... commands
brew :install, 'inetutils'

# cat alternative (https://github.com/sharkdp/bat)
brew :install, 'bat'

# json formatter (https://stedolan.github.io/jq/)
brew :install, 'jq'

# Command line tool to set file type / application associations
# (https://github.com/moretension/duti/)
brew :install, 'duti'

# Terminal alternative for macOS
brew_cask :install, 'iterm2'
additional_operations.add "Configure iTerm2 like this: https://gist.github.com/kevin-smets/8568070"
# TODO: automate this
# TODO: update custom plugins automatically

# SublimeText 3
brew_cask :install, 'sublime-text'

# Mardkdown editor
brew_cask :install, 'macdown'

# Applications
brew_cask :install, 'firefox'
brew_cask :install, 'google-chrome'
#brew_cask :install, 'slack'

# Remove associated preference files when trashing application
brew :install, 'pearcleaner'

# Move window with keyboard
brew_cask :install, 'rectangle'
additional_operations.add "Import Rectangle configuration from 'assets/rectangle-config.json'"

# yEd Graph Editor from yWorks
brew_cask :install, 'yed'

# Maven deluxe
# https://github.com/jcgay/homebrew-jcgay#maven-deluxe
brew :tap, 'jcgay/jcgay'
brew :unlink, 'maven'
brew :install, 'maven-deluxe'
brew :install, 'mvndaemon/homebrew-mvnd/mvnd'

# Asdf
brew :install, 'asdf'
additional_operations.add "Register asdf as new zsh plugin in ~/.zshrc (search 'plugins=()')"

# Java 11
additional_operations.add "asdf plugin add java"
additional_operations.add "asdf plugin-add graalvm https://github.com/asdf-community/asdf-graalvm.git"
additional_operations.add "asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git"
additional_operations.add "asdf install java temurin-11.0.19+7"
additional_operations.add "asdf set -u java temurin-11.0.19+7"
append_zsh_profile <<-TEXT
# set JAVA_HOME from asdf
. ~/.asdf/plugins/java/set-java-home.zsh
TEXT
asdfrc_content = <<-TEXT
# This replaces /??? with asdf java version
java_macos_integration_enable = yes
# Plugins with support can read the versions files used by other version managers, for example, .ruby-version in the case of Ruby's rbenv.
legacy_version_file = yes
TEXT
asdfrc = File.join(Dir.home, ".asdfrc")
append_text asdfrc_content, asdfrc

# Ruby requirements (https://github.com/rbenv/ruby-build/wiki#suggested-build-environment)
execute 'xcode-select -p 1>/dev/null 2>/dev/null || xcode-select --install'
brew :install, 'openssl@3 readline libyaml gmp autoconf'

# ruby
execute 'asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git'
execute 'asdf install ruby 3.2.2'
execute 'asdf set -u ruby 3.2.2'
asdf_config_for_ruby = <<-TEXT
# Read .ruby-version like .tool-version
legacy_version_file = yes
TEXT
append_text asdf_config_for_ruby, asdfrc


# OpenInTerminal
# https://github.com/Ji4n1ng/OpenInTerminal/blob/master/Resources/README-Lite.md
brew_cask :install, 'openinterminal-lite'
# Open new tab (not window)
execute "defaults write com.googlecode.iterm2 OpenFileInNewWindows -bool false"

# chezmoi
# www.chezmoi.io
brew :install, 'chezmoi'
execute 'chezmoi init --apply jibidus'

# Postman alternative
# paw.cloud
brew :install, 'RapidAPI'

# Notion
brew_cask :install, 'notion'

# Dive is a tool to explore docker image layers
# https://github.com/wagoodman/dive
brew :install, 'dive'

# Disk Inventory X
# https://www.derlien.com
brew_cask :install, 'disk-inventory-x'

# Sign commit with a GPG key
brew :install, 'gpg-suite'
additional_operations.add "Generate a new GPG key: https://docs.github.com/fr/authentication/managing-commit-signature-verification/generating-a-new-gpg-key"
additional_operations.add "Sign all commit with this GPG key: https://docs.github.com/fr/authentication/managing-commit-signature-verification/signing-commits"

# Clipboard manager
brew :install, 'maccy'
additional_operations.add "Open Maccy to install it"

# CLI audio/video downloader (https://github.com/yt-dlp/yt-dlp)
brew :install, 'yt-dlp'
additional_operations.add "Give full disk access to iTerm (General > Security and confidentiality)"

# Requierd by yt-dlp to merge audio and video in single file
brew :install, 'ffmpeg'
# Required by yt-dlp
brew :install, 'certifi'

# Enhance git diff
# https://difftastic.wilfred.me.uk/introduction.html
brew :install, 'difftastic'

# Docker CLI + Colima (replace Docker Desktop)
brew :install, 'docker'
ENV['DOCKER_CONFIG'] = ENV['HOME'] + "/.docker"
brew :install, 'colima'
additional_operations.add "brew services start colima"
execute <<-EOF
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-darwin-aarch64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
echo 'export DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}' >> ~/.zshrc
EOF

additional_operations.add "Install Lulu: https://objective-see.org/products/lulu.html"

# Custom aliases
append_zsh_profile <<-TEXT
# Custom aliases
source ~/.aliases
TEXT

additional_operations.print