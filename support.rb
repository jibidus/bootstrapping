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
  execute("which #{executable}")
rescue RuntimeError
  log "Prerequisite \"#{application_name}\" not installed (executable \"#{executable}\" not found in PATH environment variable)"
  exit 1
end


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
