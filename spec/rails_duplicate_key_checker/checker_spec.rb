require 'spec_helper'

describe RailsDuplicateKeyChecker::Checker do
  let(:checker) { described_class.new(analyzer) }
  let(:alter_table_statements) do
    instance_double(RailsDuplicateKeyChecker::DropIndexStatements)
  end

  describe '#run' do
    let(:analyzer) do
      instance_double(
        RailsDuplicateKeyChecker::DuplicateKeysAnalyzer,
        alter_table_statements: alter_table_statements
      )
    end

    it 'calls the analyzer' do
      expect(analyzer).to receive(:alter_table_statements)
      checker.run
    end
  end
end
