# frozen_string_literal: true

# Extracts the lines from a .log file.
class LineExtractor
  attr_reader :log_file

  def initialize(log_file)
    @log_file = log_file
  end

  def extract
    File.open(log_file).each_with_object([]) do |line, extracted_lines|
      next if line.nil?

      split_line = line.chomp.split(' ')
      next unless valid_line(split_line)

      extracted_lines << { url: split_line[0], address: split_line[1] }
    end
  end

  private

  def valid_line(line)
    return false if line.length != 2
    # Does the url contains only '/', '_', letters or numbers.
    return false unless %r{^[/_a-zA-Z0-9]+$} =~ line[0]
    # Does the address contains only '.' or numbers.
    return false unless %r{^[0-9.]+$} =~ line[1]

    true
  end
end
