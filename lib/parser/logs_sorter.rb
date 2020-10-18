# frozen_string_literal: true

# Sorts logs by count or unique count.
class LogsSorter
  def sort_by_count(parsed_logs)
    return [] unless valid_logs(parsed_logs)

    sort(parsed_logs, %i[count unique_count])
  end

  def sort_by_unique_count(parsed_logs)
    return [] unless valid_logs(parsed_logs)

    sort(parsed_logs, %i[unique_count count])
  end

  private

  def valid_logs(logs)
    return false if logs == []

    logs.is_a?(Array)
  end

  def sort(logs, sort_order)
    logs.sort_by do |log|
      [
        -log[sort_order[0]],
        -log[sort_order[1]],
        log[:url]
      ]
    end
  end
end
