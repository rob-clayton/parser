# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Parser do
  describe '.run' do
    let(:log_file) { LogFile.new }
    let(:file_not_found_error) { 'File can not be found' }
    let(:invalid_file_error) { 'Invalid file type: Please provide a .log file' }

    before(:each) do
      log_file.add_default_logs
    end

    it 'receives a log file' do
      expect(described_class.run(log_file.path))
    end

    context 'validation' do
      it 'returns an error when the provided file can not be found' do
        expect { described_class.run('') }.to raise_error(file_not_found_error)
        expect { described_class.run('fake.log') }.to raise_error(file_not_found_error)
      end

      it 'returns an error when the provided a file not a .log file' do
        invalid_file_type = Tempfile.create('test_file.rb', '/tmp').path
        expect { described_class.run(invalid_file_type) }.to raise_error(invalid_file_error)
      end
    end
  end
end
