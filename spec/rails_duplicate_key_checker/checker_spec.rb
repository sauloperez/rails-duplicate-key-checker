require 'spec_helper'

describe RailsDuplicateKeyChecker::Checker do
  let(:checker) { described_class.new(table_scanner) }

  describe '#run' do
    let(:table_scanner) { double(:table_scanner, scan: true) }

    it 'runs the command to scan the tables' do
      expect(table_scanner).to receive(:scan)
      checker.run
    end
  end
end
