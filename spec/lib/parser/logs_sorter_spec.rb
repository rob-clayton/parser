# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe LogsSorter do
  let(:parsed_logs) do
    [
      { url: '/a', count: 50, unique_count: 8, addresses: Set['1.1.1.1'] },
      { url: '/b', count: 20, unique_count: 5, addresses: Set['1.1.1.1'] },
      { url: '/c', count: 60, unique_count: 2, addresses: Set['1.1.1.1'] },
      { url: '/d', count: 40, unique_count: 4, addresses: Set['1.1.1.1'] },
      { url: '/e', count: 10, unique_count: 3, addresses: Set['1.1.1.1'] },
      { url: '/f', count: 30, unique_count: 1, addresses: Set['1.1.1.1'] }
    ]
  end

  describe '#sort_by_count' do
    it 'returns an empty Array when passed an empty array' do
      expect(subject.sort_by_count([])).to eq([])
    end

    it 'returns an empty Array when passed anything not an array' do
      expect(subject.sort_by_count({})).to eq([])
      expect(subject.sort_by_count('String')).to eq([])
      expect(subject.sort_by_count(123)).to eq([])
      expect(subject.sort_by_count(12.34)).to eq([])
      expect(subject.sort_by_count(:symbol)).to eq([])
      expect(subject.sort_by_count(nil)).to eq([])
    end

    it 'returns an Array' do
      sorted_logs = subject.sort_by_count(parsed_logs)

      expect(sorted_logs).to be_an_instance_of(Array)
      expect(sorted_logs.length).to eq(6)
    end

    it 'sorts first by count highest first' do
      expect(subject.sort_by_count(parsed_logs))
        .to eq(
          [
            { url: '/c', count: 60, unique_count: 2, addresses: Set['1.1.1.1'] },
            { url: '/a', count: 50, unique_count: 8, addresses: Set['1.1.1.1'] },
            { url: '/d', count: 40, unique_count: 4, addresses: Set['1.1.1.1'] },
            { url: '/f', count: 30, unique_count: 1, addresses: Set['1.1.1.1'] },
            { url: '/b', count: 20, unique_count: 5, addresses: Set['1.1.1.1'] },
            { url: '/e', count: 10, unique_count: 3, addresses: Set['1.1.1.1'] }
          ]
        )
    end

    it 'sorts second by unique_count highest first' do
      expect(subject.sort_by_count(
               [
                 { url: '/c', count: 10, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/a', count: 10, unique_count: 8, addresses: Set['1.1.1.1'] },
                 { url: '/d', count: 10, unique_count: 4, addresses: Set['1.1.1.1'] }
               ]
             )).to eq(
               [
                 { url: '/a', count: 10, unique_count: 8, addresses: Set['1.1.1.1'] },
                 { url: '/d', count: 10, unique_count: 4, addresses: Set['1.1.1.1'] },
                 { url: '/c', count: 10, unique_count: 2, addresses: Set['1.1.1.1'] }
               ]
             )
    end

    it 'sorts third by url alphabetically' do
      expect(subject.sort_by_count(
               [
                 { url: '/c', count: 10, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/a', count: 10, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/d', count: 10, unique_count: 2, addresses: Set['1.1.1.1'] }
               ]
             )).to eq(
               [
                 { url: '/a', count: 10, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/c', count: 10, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/d', count: 10, unique_count: 2, addresses: Set['1.1.1.1'] }
               ]
             )
    end
  end

  describe '#sort_by_unique_count' do
    it 'returns an empty Array when passed an empty array' do
      expect(subject.sort_by_unique_count([])).to eq([])
    end

    it 'returns an empty Array when passed anything not an array' do
      expect(subject.sort_by_unique_count({})).to eq([])
      expect(subject.sort_by_unique_count('String')).to eq([])
      expect(subject.sort_by_unique_count(123)).to eq([])
      expect(subject.sort_by_unique_count(12.34)).to eq([])
      expect(subject.sort_by_unique_count(:symbol)).to eq([])
      expect(subject.sort_by_unique_count(nil)).to eq([])
    end

    it 'returns an Array' do
      sorted_logs = subject.sort_by_unique_count(parsed_logs)

      expect(sorted_logs).to be_an_instance_of(Array)
      expect(sorted_logs.length).to eq(6)
    end

    it 'sorts first by unique_count highest first' do
      expect(subject.sort_by_unique_count(parsed_logs))
        .to eq(
          [
            { url: '/a', count: 50, unique_count: 8, addresses: Set['1.1.1.1'] },
            { url: '/b', count: 20, unique_count: 5, addresses: Set['1.1.1.1'] },
            { url: '/d', count: 40, unique_count: 4, addresses: Set['1.1.1.1'] },
            { url: '/e', count: 10, unique_count: 3, addresses: Set['1.1.1.1'] },
            { url: '/c', count: 60, unique_count: 2, addresses: Set['1.1.1.1'] },
            { url: '/f', count: 30, unique_count: 1, addresses: Set['1.1.1.1'] }
          ]
        )
    end

    it 'sorts second by count highest first' do
      expect(subject.sort_by_unique_count(
               [
                 { url: '/c', count: 10, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/a', count: 40, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/d', count: 30, unique_count: 2, addresses: Set['1.1.1.1'] }
               ]
             )).to eq(
               [
                 { url: '/a', count: 40, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/d', count: 30, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/c', count: 10, unique_count: 2, addresses: Set['1.1.1.1'] }
               ]
             )
    end

    it 'sorts third by url alphabetically' do
      expect(subject.sort_by_unique_count(
               [
                 { url: '/a', count: 30, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/d', count: 30, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/c', count: 30, unique_count: 2, addresses: Set['1.1.1.1'] }
               ]
             )).to eq(
               [
                 { url: '/a', count: 30, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/c', count: 30, unique_count: 2, addresses: Set['1.1.1.1'] },
                 { url: '/d', count: 30, unique_count: 2, addresses: Set['1.1.1.1'] }
               ]
             )
    end
  end
end
