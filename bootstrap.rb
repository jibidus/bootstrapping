#require_relative "traces.rb"
require "support"

manual_operations = []

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
manual_operations << "Install other oh-my-zsh plugins: https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins"
manual_operations << "Automate oh-my-zsh-update: https://github.com/ohmyzsh/ohmyzsh"
manual_operations << "Automate oh-my-zsh plugin updates: https://github.com/TamCore/autoupdate-oh-my-zsh-plugins"

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

# git diff good looking
# https://github.com/so-fancy/diff-so-fancy
brew :install, 'diff-so-fancy'

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
manual_operations << "Configure iTerm2 like this: https://gist.github.com/kevin-smets/8568070"

# SublimeText 3
brew_cask :install, 'sublime-text'

# Dash (offline API documentation)
brew_cask :install, 'dash'

# Mardkdown editor
brew_cask :install, 'macdown'

# Applications
brew_cask :install, 'firefox'
brew_cask :install, 'google-chrome'
brew_cask :install, 'skype'
brew_cask :install, 'slack'

# Remove associated preference files when trashing application
brew_cask :install, 'apptrap'

# Move window with keyboard
brew_cask :install, 'spectacle'
manual_operations << "Modify Spectacle shortcut (Ctrl+Cmd instead of Option+Cmd)"

# yEd Graph Editor from yWorks
brew_cask :install, 'yed'

# Maven with colors
# https://github.com/jcgay/maven-color
brew :tap, 'jcgay/jcgay'
brew :install, 'mvndaemon/homebrew-mvnd/mvnd'

# Dependencies of asdf
# (https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies)
brew :install, 'spack'
brew :install, 'coreutils'
asdf_home = File.join(Dir.home, ".asdf")
unless Dir.exist?(asdf_home)
    execute 'git clone https://github.com/asdf-vm/asdf.git #{asdf_home} --branch v0.13.1'
end
manual_operations << "Register asdf as new zsh plugin in ~/.zshrc (search 'plugins=()')"

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

puts "There are some manual operations left:"
puts "\t- Install Dbeaver Community Edition manually: https://dbeaver.io/download/"
puts "\t- Install docker: https://www.docker.com/get-started/"
puts "\t- Configure Homebrew completions: https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh"
manual_operations.each do |operation|
    puts "\t- #{operation}"
end
