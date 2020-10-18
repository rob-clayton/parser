# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Parser do
  describe '#run' do
    let(:log_file) { LogFile.new }
    let(:file_not_found_error) { 'File can not be found' }
    let(:invalid_file_error) { 'Invalid file type: Please provide a .log file' }

    before(:each) do
      log_file.add_line('/home 184.123.665.067')
      log_file.add_line('/about/2 444.701.448.104')
      log_file.add_line('/help_page/1 929.398.951.889')
      log_file.add_line('/index 444.701.448.104')
    end

    it 'receives a log file' do
      expect(subject.run(log_file.path))
    end

    context 'validation' do
      it 'returns an error when the provided file can not be found' do
        expect { subject.run('') }.to raise_error(file_not_found_error)
        expect { subject.run('fake.log') }.to raise_error(file_not_found_error)
      end

      it 'returns an error when the provided a file not a .log file' do
        invalid_file_type = Tempfile.create('test_file.rb', '/tmp').path
        expect { subject.run(invalid_file_type) }.to raise_error(invalid_file_error)
      end
    end
  end
end
