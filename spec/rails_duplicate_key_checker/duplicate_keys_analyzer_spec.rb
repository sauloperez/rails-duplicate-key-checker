require 'spec_helper'

module RailsDuplicateKeyChecker
  describe DuplicateKeysAnalyzer do
    let(:duplicate_keys_analyzer) { described_class.new }

    describe '#alter_table_statements' do
      subject { duplicate_keys_analyzer.alter_table_statements }

      let(:statements) { double(:statements) }
      let(:drop_index_statements) do
        instance_double(DropIndexStatements, parse: statements)
      end

      before do
        allow(DropIndexStatements)
          .to receive(:new).with('command output')
          .and_return(drop_index_statements)
      end

      before do
        allow(Kernel)
          .to receive(:system)
          .with('pt-duplicate-key-checker D=teambox_development -u root')
          .and_return('command output')
      end

      context 'when the pt-duplicate-key-checker command is successful' do
        before { allow($?).to receive(:exitstatus).and_return(0) }

        it 'raises a InvalidScanError' do
          expect { duplicate_keys_analyzer.scan }
            .not_to raise_error(DuplicateKeysAnalyzer::InvalidScanError)
        end

        it 'calls #parse on the drop index statements' do
          expect(drop_index_statements).to receive(:parse)
          duplicate_keys_analyzer.alter_table_statements
        end

        it 'returns parsed drop index statements' do
          expect(duplicate_keys_analyzer.alter_table_statements)
            .to eq(statements)
        end
      end

      context 'when the pt-duplicate-key-checker command is unsuccessful' do
        before do
          allow($?).to receive(:exitstatus).and_return(-1)
        end

        it 'raises a InvalidScanError' do
          expect { duplicate_keys_analyzer.alter_table_statements }
            .to raise_error(DuplicateKeysAnalyzer::InvalidScanError)
        end
      end
    end
  end
end
