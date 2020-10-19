# frozen_string_literal: true

require 'terminal-table'

# Uses the terminal-table gem to format and print a table to STDOUT
class LogsPresenter
  URL_HEADING = 'URL'
  COUNT_HEADING = 'Total views'
  UNIQUE_COUNT_HEADING = 'Unique views'

  def present_by_count(sorted_logs)
    return unless valid_logs(sorted_logs)

    puts_table(
      sorted_logs.map { |log| [log[:url], log[:count]] },
      [URL_HEADING, COUNT_HEADING],
      COUNT_HEADING
    )
  end

  def present_by_unique_count(sorted_logs)
    return unless valid_logs(sorted_logs)

    puts_table(
      sorted_logs.map { |log| [log[:url], log[:unique_count]] },
      [URL_HEADING, UNIQUE_COUNT_HEADING],
      UNIQUE_COUNT_HEADING
    )
  end

  private

  def valid_logs(logs)
    return false if logs == []

    logs.is_a?(Array)
  end

  def puts_table(rows, headings, title)
    puts Terminal::Table.new(
      title: title,
      headings: headings,
      rows: rows
    )
  end
end
