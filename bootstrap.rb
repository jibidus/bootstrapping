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
  Open3.popen2e command do |stdin, stdout_err, wait_thr|
    while line = stdout_err.gets
      log line
    end

    exit_status = wait_thr.value
    unless exit_status.success?
      log "Command failed with following exit status: #{exit_status}"
      log "Executed command: #{command}"
    end
    return exit_status.success?
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

check_prerequisite "brew" "Homebrew"
check_prerequisite "git" "Git"




# Brew formulas
# ---------------------------------------------------------

def brew(command, formula)
  execute "brew #{command.to_s} #{formula}"
end

BASH_PROFILE = '~/.bash_profile'
require 'fileutils'

def append_bash_profile(text)
  # TODO Create ~/.bash_profile if not exist
  FileUtils.touch(BASH_PROFILE) unless File.exist?(BASH_PROFILE)
  append_text text, BASH_PROFILE
end


# trash files instead of 'rm' command
brew :install "rmtrash"
append_bash_profile <<-TEXT
# rmtrash
alias trash='rmtrash'
alias trashdir='rmdirtrash'
TEXT

# Github app to drive github from command line
brew :install "hub"

# Maven with colors
# https://github.com/jcgay/maven-color
brew :tap "jcgay/jcgay"
brew :install "maven-deluxe"

# Gradle
brew :install "gradle"

# Java decompiler
brew :install "jad"
# Spring boot CLI
brew :tap "pivotal/tap"
brew :install "springboot"

# Google Protocol Buffer
brew :install "protobuf"

# Javascript
brew :install "phantomjs"

brew :install "gpg-agent"
brew :install "scala"

# Node.js
brew :install "node"

# Better curl
brew :install "httpie"

# Mysql server and client
brew :install "mysql"

# Rbenv
brew :install "rbenv"
brew :install "ruby-build"
append_bash_profile <<-TEXT
# Rbenv
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
TEXT

# git diff good looking
# https://github.com/so-fancy/diff-so-fancy
brew :install "diff-so-fancy"

# AsciiDoc text document format manipulation (http://asciidoc.org)
brew :install "asciidoc"


# Brew casks
# ---------------------------------------------------------

def brew_cask_install(formula)
  execute "brew cask install #{formula}"
end

def application_id(application)
  app_path = "/Applications/#{application}.app"
  if File.exist?(app_path)
    return `mdls -name kMDItemCFBundleIdentifier -r #{app_path}`
  else
    raise "Application #{application} not found (in /Applications)"
  end
end

brew :install "duti"

def associate_files_to(extension, application)
  app_id = application_id(application)
  log "Application Id found for application #{application}: #{app_id}"
  execute "duti -s #{app_id} #{extension} all"
end

# Vagrant
brew_cask_install vagrant

# Github desktop client
brew_cask_install github-desktop

# gitup.co / Git UI
brew_cask_install gitup

# SublimeText 3
brew_cask_install sublim-text

# Dash (offline API documentation)
brew_cask_install dash

# Basecamp desktop client
brew_cask_install basecamp

# Database desktop client
brew_cask_install 'dbeaver-community'

brew_cask_install pg-commander

brew_cask_install 'postgres'
# TODO Update PATH with /Applications/Postgres.app/Contents/Versions/latest/bin


# Mardkdown editor
brew_cask_install macdown
associate_files_to '.md', 'MacDown'

# Applications
brew_cask_install 'firefox'
brew_cask_install 'google-chrome'
brew_cask_install 'skype'
brew_cask_install 'slack'
brew_cask_install 'dropbox'
brew_cask_install 'atom'
brew_cask_install 'google-hangouts'

# Hangouts desktop client
brew_cask_install 'yakyak'

# Remove associated preference files when trashing application
brew_cask_install 'apptrap'

# yEd Graph Editor from yWorks
brew_cask_install 'yed'
