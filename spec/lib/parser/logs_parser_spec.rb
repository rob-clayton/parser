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

    it 'returns a Hash' do
      parsed_lines = subject.parse(default_logs)

      expect(parsed_lines).to be_an_instance_of(Hash)
      expect(parsed_lines.length).to eq(4)
    end

    it 'creates a Hash entry for each log' do
      expected_results = {
        '/home' => { count: 1, unique_count: 1, addresses: Set['184.123.665.067'] },
        '/about/2' => { count: 1, unique_count: 1, addresses: Set['444.701.448.104'] },
        '/help_page/1' => { count: 1, unique_count: 1, addresses: Set['929.398.951.889'] },
        '/index' => { count: 1, unique_count: 1, addresses: Set['444.701.448.104'] }
      }
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
        expected_results = {
          '/home' => {
            count: 5,
            unique_count: 5,
            addresses: Set['1.1.1.1', '2.2.2.2', '3.3.3.3', '4.4.4.4', '5.5.5.5']
          }
        }

        expect(subject.parse(logs)).to eq(expected_results)
        expect(subject.parse(logs)['/home'][:count]).to eq(5)
      end
    end

    context 'unique visits' do
      context 'unique count' do
        it 'does not create a unique visit if an address has already visited a url' do
          logs = [
            { url: '/home', address: '1.1.1.1' },
            { url: '/home', address: '1.1.1.1' }
          ]

          expect(subject.parse(logs)['/home'][:unique_count]).to eq(1)
        end

        it 'creates a unique visit if an address has not visited a url' do
          logs = [
            { url: '/home', address: '1.1.1.1' },
            { url: '/home', address: '2.2.2.2' }
          ]

          expect(subject.parse(logs)['/home'][:unique_count]).to eq(2)
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

          expect(subject.parse(logs)['/home'][:addresses])
            .to eq(Set['1.1.1.1', '3.3.3.3', '5.5.5.5'])
        end
      end
    end
  end
end
