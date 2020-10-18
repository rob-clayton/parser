# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe LogsExtractor do
  describe '#extract' do
    let(:log_file) { LogFile.new }
    let(:default_log_file) { LogFile.new }

    before(:each) do
      default_log_file.add_default_logs
    end

    it 'returns an empty Array when log file is empty' do
      expect(subject.extract(log_file.path)).to eq([])
    end

    it 'return an Array of Hashes' do
      extracted_logs = subject.extract(default_log_file.path)

      expect(extracted_logs).to be_an_instance_of(Array)
      expect(extracted_logs.length).to eq(4)
      extracted_logs.each do |log|
        expect(log).to be_an_instance_of(Hash)
      end
    end

    it 'splits each log on white space seporating the url and the address' do
      expect(subject.extract(default_log_file.path))
        .to eq(
          [
            { url: '/home', address: '184.123.665.067' },
            { url: '/about/2', address: '444.701.448.104' },
            { url: '/help_page/1', address: '929.398.951.889' },
            { url: '/index', address: '444.701.448.104' }
          ]
        )
    end

    context 'validation' do
      it 'ignores a log if there is more or less than two strings' do
        logs = log_file.clone
        logs.add_logs(
          [
            '/home',
            '929.398.951.889',
            '/index444.701.448.104',
            '/home 929 398 951 889',
            '/index /home 444.701.448.104',
            '/home    184.123.665.067',
            '/home 184.123.665.068'
          ]
        )

        expect(subject.extract(logs.path))
          .to eq(
            [
              { url: '/home', address: '184.123.665.067' },
              { url: '/home', address: '184.123.665.068' }
            ]
          )
      end

      it "ignores a url that does not contain only '/', '_', letters or numbers" do
        logs = log_file.clone
        logs.add_logs(
          [
            '/home_a/12/cde 184.123.665.067',
            '/home&23 184.123.665.067',
            '/home+123 184.123.665.067',
            '/home 184.123.665.067'
          ]
        )

        expect(subject.extract(logs.path))
          .to eq(
            [
              { url: '/home_a/12/cde', address: '184.123.665.067' },
              { url: '/home', address: '184.123.665.067' }
            ]
          )
      end

      it "ignores an address that does not contain only '.' or numbers" do
        logs = log_file.clone
        logs.add_logs(
          [
            '/home abc.def.665.067',
            '/home 184.+.665.067',
            '/home 184_123_665_067',
            '/home 184.123.665.067'
          ]
        )

        expect(subject.extract(logs.path))
          .to eq([{ url: '/home', address: '184.123.665.067' }])
      end
    end
  end
end
