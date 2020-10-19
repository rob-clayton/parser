# frozen_string_literal: true

require_relative '../../spec_helper'

require 'pry'

RSpec.describe LogsPresenter do
  describe '#sort_by_count' do
    let(:sorted_by_count) do
      [
        { url: '/c', count: 60, unique_count: 2, addresses: Set['1.1.1.1'] },
        { url: '/a', count: 50, unique_count: 8, addresses: Set['1.1.1.1'] },
        { url: '/d', count: 40, unique_count: 4, addresses: Set['1.1.1.1'] },
        { url: '/f', count: 30, unique_count: 1, addresses: Set['1.1.1.1'] },
        { url: '/b', count: 20, unique_count: 5, addresses: Set['1.1.1.1'] },
        { url: '/e', count: 10, unique_count: 3, addresses: Set['1.1.1.1'] }
      ]
    end

    it 'does not print anything to STDOUT when passed an empty array' do
      expect { subject.present_by_count([]) }.to_not output.to_stdout
    end

    it 'does not print anything to STDOUT when passed anything not an array' do
      expect { subject.present_by_count({}) }.to_not output.to_stdout
      expect { subject.present_by_count('String') }.to_not output.to_stdout
      expect { subject.present_by_count(123) }.to_not output.to_stdout
      expect { subject.present_by_count(12.34) }.to_not output.to_stdout
      expect { subject.present_by_count(:symbol) }.to_not output.to_stdout
      expect { subject.present_by_count(nil) }.to_not output.to_stdout
    end

    it 'prints a table to the console sorted by Count, largest first' do
      expected_output = "+-----+-------------+\n"\
                        "|    Total views    |\n"\
                        "+-----+-------------+\n"\
                        "| URL | Total views |\n"\
                        "+-----+-------------+\n"\
                        "| /c  | 60          |\n"\
                        "| /a  | 50          |\n"\
                        "| /d  | 40          |\n"\
                        "| /f  | 30          |\n"\
                        "| /b  | 20          |\n"\
                        "| /e  | 10          |\n"\
                        "+-----+-------------+\n"

      expect { subject.present_by_count(sorted_by_count) }.to output(expected_output).to_stdout
    end
  end

  describe '#present_by_unique_count' do
    let(:sorted_by_unique_count) do
      [
        { url: '/a', count: 50, unique_count: 8, addresses: Set['1.1.1.1'] },
        { url: '/b', count: 20, unique_count: 5, addresses: Set['1.1.1.1'] },
        { url: '/d', count: 40, unique_count: 4, addresses: Set['1.1.1.1'] },
        { url: '/e', count: 10, unique_count: 3, addresses: Set['1.1.1.1'] },
        { url: '/c', count: 60, unique_count: 2, addresses: Set['1.1.1.1'] },
        { url: '/f', count: 30, unique_count: 1, addresses: Set['1.1.1.1'] }
      ]
    end

    it 'does not print anything to STDOUT when passed an empty array' do
      expect { subject.present_by_unique_count([]) }.to_not output.to_stdout
    end

    it 'does not print anything to STDOUT when passed anything not an array' do
      expect { subject.present_by_unique_count({}) }.to_not output.to_stdout
      expect { subject.present_by_unique_count('String') }.to_not output.to_stdout
      expect { subject.present_by_unique_count(123) }.to_not output.to_stdout
      expect { subject.present_by_unique_count(12.34) }.to_not output.to_stdout
      expect { subject.present_by_unique_count(:symbol) }.to_not output.to_stdout
      expect { subject.present_by_unique_count(nil) }.to_not output.to_stdout
    end

    it 'prints a table to the console sorted by Unique Count, largest first' do
      expected_output = "+-----+--------------+\n"\
                        "|    Unique views    |\n"\
                        "+-----+--------------+\n"\
                        "| URL | Unique views |\n"\
                        "+-----+--------------+\n"\
                        "| /a  | 8            |\n"\
                        "| /b  | 5            |\n"\
                        "| /d  | 4            |\n"\
                        "| /e  | 3            |\n"\
                        "| /c  | 2            |\n"\
                        "| /f  | 1            |\n"\
                        "+-----+--------------+\n"

      expect { subject.present_by_unique_count(sorted_by_unique_count) }.to output(expected_output).to_stdout
    end
  end
end
