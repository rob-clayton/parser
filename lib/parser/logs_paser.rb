# frozen_string_literal: true

require 'set'

# Counts the visits for each log.
class LogsParser
  def parse(logs)
    return {} if logs == []
    return {} unless logs.is_a?(Array)

    count_visits(logs)
  end

  private

  def count_visits(logs)
    logs.each_with_object({}) do |log, visits|
      url = log[:url]

      visits[url] = case visits[url]
                    when nil
                      new_visit(log)
                    else
                      additional_visit(visits[url], log)
                    end
    end
  end

  def new_visit(log)
    {
      count: 1,
      unique_count: 1,
      addresses: Set[log[:address]]
    }
  end

  def additional_visit(visit, log)
    {
      count: visit[:count] += 1,
      unique_count: visit[:addresses].include?(log[:address]) ? visit[:unique_count] : visit[:unique_count] += 1,
      addresses: visit[:addresses].add(log[:address])
    }
  end
end
