require 'spec_helper'

describe RailsDuplicateKeyChecker::TableScanner do
  let(:table_scanner) { described_class.new }

  describe '#scan' do
    before do
      allow(Kernel).to receive(:system).with('pt-duplicate-key-checker')
    end

    context 'when the pt-duplicate-key-checker command is successful' do
      before do
        allow($?).to receive(:exitstatus).and_return(0)
      end

      it 'raises a InvalidScanError' do
        expect { table_scanner.scan }
          .not_to raise_error(RailsDuplicateKeyChecker::TableScanner::InvalidScanError)
      end
    end

    context 'when the pt-duplicate-key-checker command is unsuccessful' do
      before do
        allow($?).to receive(:exitstatus).and_return(-1)
      end

      it 'raises a InvalidScanError' do
        expect { table_scanner.scan }
          .to raise_error(RailsDuplicateKeyChecker::TableScanner::InvalidScanError)
      end
    end
  end

  describe '#alter_table_statements' do
  end
end
