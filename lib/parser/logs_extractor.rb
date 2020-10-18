# frozen_string_literal: true

# Extracts the logs from a .log file.
class LogsExtractor
  def extract(log_file)
    File.open(log_file).each_with_object([]) do |log, extracted_logs|
      next if log.nil?

      split_log = log.chomp.split(' ')
      next unless valid_log(split_log)

      extracted_logs << { url: split_log[0], address: split_log[1] }
    end
  end

  private

  def valid_log(log)
    return false if log.length != 2
    # Does the url contains only '/', '_', letters or numbers.
    return false unless %r{^[/_a-zA-Z0-9]+$} =~ log[0]
    # Does the address contains only '.' or numbers.
    return false unless /^[0-9.]+$/ =~ log[1]

    true
  end
end
