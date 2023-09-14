#require_relative "traces.rb"


def append_text(text, file_path)
  open(file_path, 'a') { |f| f << text }
end

# TODO Create class dedicated to logs
# Create new log file
current_folder = File.expand_path(File.dirname(__FILE__))
logs_folder = File.join(current_folder, "logs")
Dir.mkdir(logs_folder) unless Dir.exist?(logs_folder)
timestamp = Time.now.strftime("%Y-%m-%d_%Hh%Mm%Ss")
LOG_FILE = File.join(logs_folder, "bootstrap_#{timestamp}.log")

def log(message)
  puts message
  append_text message, LOG_FILE
end


require 'open3'

def execute(command)
  Open3.popen2e command do |_, stdout_err, wait_thr|
    while (line = stdout_err.gets)
      log line
    end

    exit_status = wait_thr.value
    unless exit_status.success?
      raise "Command '#{command}' failed with exit status #{exit_status}"
    end
  end
end


def check_prerequisite(executable, application_name)
  unless execute("which #{executable}")
    log "Prerequisite \"#{application_name}\" not installed (executable \"#{executable}\" not found in PATH environment variable)"
    exit 1
  end
end


# Check prerequisites
# ---------------------------------------------------------

check_prerequisite 'brew', 'Homebrew'
check_prerequisite 'git', 'Git'


# Oh-my-zsh
#
# ---------------------------------------------------------

execute 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'


# Brew formulas
# ---------------------------------------------------------

def brew(command, formula)
  execute "brew #{command.to_s} #{formula}"
end

def brew_cask(command, formula)
  execute "brew #{command.to_s} --cask #{formula}"
end

ZSHRC = File.join(Dir.home, ".zshrc")
require 'fileutils'

def append_zsh_profile(text)
  FileUtils.touch(ZSHRC) unless File.exist?(ZSHRC)
  append_text text, ZSHRC
end

# Git: ignore all .DS_Store
global_gitignore="~/.gitignore"
execute "git config --global core.excludesFile '#{global_gitignore}'"
FileUtils.touch(global_gitignore) unless File.exist?(global_gitignore)
append_text ".DS_Store", global_gitignore

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

# Brew casks
# ---------------------------------------------------------

def application_id(application)
  app_path = "/Applications/#{application}.app"
  if File.exist?(app_path)
    return `mdls -name kMDItemCFBundleIdentifier -r #{app_path}`
  else
    raise "Application #{application} not found (in /Applications)"
  end
end

# Command line tool to set file type / application associations
# (https://github.com/moretension/duti/)
brew :install, 'duti'

def associate_files_to(extension, application)
  app_id = application_id(application)
  log "Application Id found for application #{application}: #{app_id}"
  execute "duti -s #{app_id} #{extension} all"
end

# gitup.co / Git UI
brew_cask :install, 'gitup'

# Terminal alternative for macOS
brew_cask :install, 'iterm2'

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
brew_cask :install, 'dropbox'

# Remove associated preference files when trashing application
brew_cask :install, 'apptrap'

# The Spotlight of the user interface, in order to control the Mac from keyboard
brew_cask :install, 'shortcat'

# Move window with keyboard
brew_cask :install, 'spectacle'

# yEd Graph Editor from yWorks
brew_cask :install, 'yed'

# Maven with colors
# https://github.com/jcgay/maven-color
brew :tap, 'jcgay/jcgay'
brew :install, 'maven-deluxe'
brew :install, 'mvndaemon/homebrew-mvnd/mvnd'

# Dependencies of asdf
# (https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies)
brew :install, 'spack'
brew :install, 'coreutils'
execute 'git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0'

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