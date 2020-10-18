# frozen_string_literal: true

class LogFile
  attr_reader :path

  def initialize
    @path = Tempfile.create(['stubbed_logs', '.log'], '/tmp').path
  end

  def add_line(line)
    File.open(path, 'a') do |file|
      file.puts(line.to_s)
    end
  end
end
