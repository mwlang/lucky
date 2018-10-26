require "lucky_cli"
require "colorize"

class Build::Release < LuckyCli::Task
  include LuckyCli::TextHelpers

  banner "Compile app for production"

  def initialize(@io : IO = STDOUT, @error_io : IO = STDERR)
  end

  def call
    command = "crystal build --release src/server.cr"

    log "Building binary with '#{command}"
    process = Process.run(command, shell: true, output: @io, error: @error_io)
    if process.success?
      log "Build succeeded - binary saved at './server'"
    end
  end

  def log(message)
    @io.puts "  #{green_arrow} #{message}"
  end
end
