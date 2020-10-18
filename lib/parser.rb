# frozen_string_literal: true

# Entry class for the Parser.
class Parser
  FILE_NOT_FOUND_ERROR = 'File can not be found'
  INVALID_FILE_TYPE_ERROR = 'Invalid file type: Please provide a .log file'

  def run(log_file)
    validate_log_file(log_file)
  end

  private

  def validate_log_file(log_file)
    raise StandardError, FILE_NOT_FOUND_ERROR unless log_file.nil? || File.file?(log_file)
    raise StandardError, INVALID_FILE_TYPE_ERROR unless File.extname(log_file) == '.log'
  end
end
