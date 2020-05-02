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
  execute "brew cask #{command.to_s} #{formula}"
end

ZSHRC = '~/.zshrc'
require 'fileutils'

def append_zsh_profile(text)
  FileUtils.touch(ZSHRC) unless File.exist?(ZSHRC)
  append_text text, ZSHRC
end


# trash files instead of 'rm' command
brew :install "rmtrash"
append_zsh_profile <<-TEXT
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
append_zsh_profile <<-TEXT
# Rbenv
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.zshrc
TEXT

# git diff good looking
# https://github.com/so-fancy/diff-so-fancy
brew :install "diff-so-fancy"

# AsciiDoc text document format manipulation (http://asciidoc.org)
brew :install "asciidoc"

# ftp, telnet... commands
brew :install "inetutils"


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

brew :install "duti"

def associate_files_to(extension, application)
  app_id = application_id(application)
  log "Application Id found for application #{application}: #{app_id}"
  execute "duti -s #{app_id} #{extension} all"
end

# gitup.co / Git UI
brew_cask :install 'gitup'

# gitup.co / Git UI
brew_cask :install 'iterm2'

# SublimeText 3
brew_cask :install 'sublim-text'

# Dash (offline API documentation)
brew_cask :install 'dash'

# Basecamp desktop client
brew_cask :install 'basecamp'

# Database desktop client
brew_cask :install 'dbeaver-community'

brew_cask :install 'pg-commander'

brew_cask :install 'postgres'
# TODO Update PATH with /Applications/Postgres.app/Contents/Versions/latest/bin


# Mardkdown editor
brew_cask :install 'macdown'
associate_files_to '.md', 'MacDown'

# Applications
brew_cask :install 'firefox'
brew_cask :install 'google-chrome'
brew_cask :install 'skype'
brew_cask :install 'slack'
brew_cask :install 'dropbox'

# Remove associated preference files when trashing application
brew_cask :install 'apptrap'

# yEd Graph Editor from yWorks
brew_cask :install 'yed'

# Java
brew_cask :install 'java' # JVM 11+
execute 'brew tap AdoptOpenJDK/openjdk'
brew_cask :install 'adoptopenjdk8'
brew :install 'jenv'
execute 'jenv enable-plugin export'
append_zsh_profile <<-TEXT
# Java environment management
export PATH="$HOME/.jenv/bin:$PATH"
eval \"$(jenv init -)\"
TEXT
# Configure all installed JVM
require 'pathname'
Pathname.new('/Library/Java/JavaVirtualMachines')
        .children
        .select(&:directory?)
        .each do |jvm_home|
    execute "jenv add #{jvm_home.join('Contents/Home/')}"
end
