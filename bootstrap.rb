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
  execute "brew cask #{command.to_s} #{formula}"
end

ZSHRC = File.join(Dir.home, ".zshrc")
require 'fileutils'

def append_zsh_profile(text)
  FileUtils.touch(ZSHRC) unless File.exist?(ZSHRC)
  append_text text, ZSHRC
end


# trash files instead of 'rm' command
brew :install, 'rmtrash'
append_zsh_profile <<-TEXT
# rmtrash
alias trash='rmtrash'
alias trashdir='rmdirtrash'
TEXT

# Github app to drive github from command line
brew :install, 'hub'

# Gradle
brew :install, 'gradle'

# Spring boot CLI
brew :tap, 'pivotal/tap'
brew :install, 'springboot'

# Node Version Manager
brew :install, 'nvm'
execute 'mkdir ~/.nvm'
append_zsh_profile <<-TEXT
# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
TEXT

# Better curl
brew :install, 'httpie'

# Mysql server and client
brew :install, 'mysql'

# Rbenv
brew :install, 'rbenv'
brew :install, 'ruby-build'
append_zsh_profile <<-TEXT
# Rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
TEXT

# git diff good looking
# https://github.com/so-fancy/diff-so-fancy
brew :install, 'diff-so-fancy'

# AsciiDoc text document format manipulation (http://asciidoc.org)
brew :install, 'asciidoc'

# ftp, telnet... commands
brew :install, 'inetutils'

# cat alternative (https://github.com/sharkdp/bat)
brew :install, 'bat'

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

brew :install, 'duti'

def associate_files_to(extension, application)
  app_id = application_id(application)
  log "Application Id found for application #{application}: #{app_id}"
  execute "duti -s #{app_id} #{extension} all"
end

# gitup.co / Git UI
brew_cask :install, 'gitup'

# gitup.co / Git UI
brew_cask :install, 'iterm2'

# SublimeText 3
brew_cask :install, 'sublime-text'

# Dash (offline API documentation)
brew_cask :install, 'dash'

# Basecamp desktop client
brew_cask :install, 'basecamp'

brew_cask :install, 'postgres'
# TODO Update PATH with /Applications/Postgres.app/Contents/Versions/latest/bin
append_zsh_profile <<-TEXT
# Postgres
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
TEXT


# Java decompiler
brew_cask :install, 'jad'

# Mardkdown editor
brew_cask :install, 'macdown'
associate_files_to '.md', 'MacDown'

# Applications
brew_cask :install, 'firefox'
brew_cask :install, 'google-chrome'
brew_cask :install, 'skype'
brew_cask :install, 'slack'
brew_cask :install, 'dropbox'

# Remove associated preference files when trashing application
brew_cask :install, 'apptrap'

# yEd Graph Editor from yWorks
brew_cask :install, 'yed'

# Jabba (Java version manager)
execute 'curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash && . ~/.jabba/jabba.sh'
execute 'source ~/.jabba/jabba.sh && jabba install adopt@1.8-0'
# Jenv
brew :install, 'jenv'
execute 'source ~/.jabba/jabba.sh && eval "$(jenv init -)" && unset JAVA_TOOL_OPTIONS && jenv add "$(jabba which adopt@1.8-0)/Contents/Home/"'
execute 'jenv global 1.8'

# Maven with colors
# https://github.com/jcgay/maven-color
brew :tap, 'jcgay/jcgay'
brew :install, 'maven-deluxe'
