require 'spec_helper'

module RailsDuplicateKeyChecker
  describe DuplicateKeysAnalyzer do
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
            .not_to raise_error(DuplicateKeysAnalyzer::InvalidScanError)
        end
      end

      context 'when the pt-duplicate-key-checker command is unsuccessful' do
        before do
          allow($?).to receive(:exitstatus).and_return(-1)
        end

        it 'raises a InvalidScanError' do
          expect { table_scanner.scan }
            .to raise_error(DuplicateKeysAnalyzer::InvalidScanError)
        end
      end
    end

    describe '#alter_table_statements' do
      subject { table_scanner.alter_table_statements }

      let(:drop_index_statements) do
        instance_double(DropIndexStatements)
      end

      before do
        allow(DropIndexStatements)
          .to receive(:new).with('command output').and_return(drop_index_statements)
      end

      before do
        allow(Kernel)
          .to receive(:system).with('pt-duplicate-key-checker').and_return('command output')
        table_scanner.scan
      end

      it { is_expected.to eq(drop_index_statements) }
    end
  end
end
