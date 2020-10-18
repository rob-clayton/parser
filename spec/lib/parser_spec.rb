# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Parser do
  describe '#run' do
    let(:log_file) { LogFile.new }

    before(:each) do
      log_file.add_line('/home 184.123.665.067')
      log_file.add_line('/about/2 444.701.448.104')
      log_file.add_line('/help_page/1 929.398.951.889')
      log_file.add_line('/index 444.701.448.104')
    end

    it 'receives a log file' do
      expect(subject.run(log_file))
    end
  end
end
