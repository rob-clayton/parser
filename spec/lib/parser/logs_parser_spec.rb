# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe LogsParser do
  describe '#parse' do
    let(:default_logs) do
      [
        { url: '/home', address: '184.123.665.067' },
        { url: '/about/2', address: '444.701.448.104' },
        { url: '/help_page/1', address: '929.398.951.889' },
        { url: '/index', address: '444.701.448.104' }
      ]
    end

    it 'returns an empty Hash when passed an empty array' do
      expect(subject.parse([])).to eq({})
    end

    it 'returns an empty Hash when passed anything not an array' do
      expect(subject.parse({})).to eq({})
      expect(subject.parse('String')).to eq({})
      expect(subject.parse(123)).to eq({})
      expect(subject.parse(12.34)).to eq({})
      expect(subject.parse(:symbol)).to eq({})
    end

    it 'returns an Array of Hashes' do
      parsed_logs = subject.parse(default_logs)

      expect(parsed_logs).to be_an_instance_of(Array)
      expect(parsed_logs.length).to eq(4)
      parsed_logs.each do |log|
        expect(log).to be_an_instance_of(Hash)
      end
    end

    it 'creates a Hash for each url' do
      expected_results = [
        { url: '/home', count: 1, unique_count: 1, addresses: Set['184.123.665.067'] },
        { url: '/about/2', count: 1, unique_count: 1, addresses: Set['444.701.448.104'] },
        { url: '/help_page/1', count: 1, unique_count: 1, addresses: Set['929.398.951.889'] },
        { url: '/index', count: 1, unique_count: 1, addresses: Set['444.701.448.104'] }
      ]
      expect(subject.parse(default_logs)).to eq(expected_results)
    end

    context 'visit count' do
      it 'increases the count for every visit' do
        logs = [
          { url: '/home', address: '1.1.1.1' },
          { url: '/home', address: '2.2.2.2' },
          { url: '/home', address: '3.3.3.3' },
          { url: '/home', address: '4.4.4.4' },
          { url: '/home', address: '5.5.5.5' }
        ]
        expected_results = [
          url: '/home',
          count: 5,
          unique_count: 5,
          addresses: Set['1.1.1.1', '2.2.2.2', '3.3.3.3', '4.4.4.4', '5.5.5.5']
        ]

        expect(subject.parse(logs)).to eq(expected_results)
      end
    end

    context 'unique visits' do
      context 'unique count' do
        it 'does not create a unique visit if an address has already visited a url' do
          logs = [
            { url: '/home', address: '1.1.1.1' },
            { url: '/home', address: '1.1.1.1' }
          ]

          expect(subject.parse(logs).first[:unique_count]).to eq(1)
        end

        it 'creates a unique visit if an address has not visited a url' do
          logs = [
            { url: '/home', address: '1.1.1.1' },
            { url: '/home', address: '2.2.2.2' }
          ]

          expect(subject.parse(logs).first[:unique_count]).to eq(2)
        end
      end

      context 'addresses' do
        it 'stores each new address' do
          logs = [
            { url: '/home', address: '1.1.1.1' },
            { url: '/home', address: '3.3.3.3' },
            { url: '/home', address: '1.1.1.1' },
            { url: '/home', address: '5.5.5.5' },
            { url: '/home', address: '1.1.1.1' }
          ]

          expect(subject.parse(logs).first[:addresses])
            .to eq(Set['1.1.1.1', '3.3.3.3', '5.5.5.5'])
        end
      end
    end
  end
end
