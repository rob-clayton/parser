# frozen_string_literal: true

class LogFile
  attr_reader :path

  def initialize
    @path = Tempfile.create(['stubbed_logs', '.log'], '/tmp').path
  end

  def add_default_logs
    add_logs(
      [
        '/home 184.123.665.067',
        '/about/2 444.701.448.104',
        '/help_page/1 929.398.951.889',
        '/index 444.701.448.104'
      ]
    )
  end

  def add_logs(logs)
    logs.each do |log|
      add_line(log)
    end
  end

  def add_line(line)
    File.open(path, 'a') do |file|
      file.puts(line.to_s)
    end
  end
end
