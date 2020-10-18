# frozen_string_literal: true

class LogFile
  attr_reader :temp_file

  def initialize
    @temp_file = Tempfile.new('stubbed_logs.log', '/tmp').path
  end

  def add_line(line)
    File.open(temp_file, 'a') do |file|
      file.puts(line.to_s)
    end
  end
end
