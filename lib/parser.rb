# frozen_string_literal: true

require 'require_all'
require_all './lib/parser'

# Entry class for the Parser.
class Parser
  FILE_NOT_FOUND_ERROR = 'File can not be found'
  INVALID_FILE_TYPE_ERROR = 'Invalid file type: Please provide a .log file'

  def run(log_file)
    validate_log_file(log_file)

    logs = LogsExtractor.new.extract(log_file)
    parsed_data = LogsParser.new.parse(logs)
    sorted_by_count = LogsSorter.new.sort_by_count(parsed_data)
    sorted_by_unique = LogsSorter.new.sort_by_unique_count(parsed_data)

    LogsPresenter.new.present_by_count(sorted_by_count)
    LogsPresenter.new.present_by_unique_count(sorted_by_unique)
  end

  private

  def validate_log_file(log_file)
    raise StandardError, FILE_NOT_FOUND_ERROR unless log_file.nil? || File.file?(log_file)
    raise StandardError, INVALID_FILE_TYPE_ERROR unless File.extname(log_file) == '.log'
  end
end
