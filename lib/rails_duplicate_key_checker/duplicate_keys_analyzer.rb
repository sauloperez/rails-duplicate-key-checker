require 'rails_duplicate_key_checker/drop_index_statements'

module RailsDuplicateKeyChecker
  class DuplicateKeysAnalyzer
    class InvalidScanError < StandardError; end

    def alter_table_statements
      @alter_table_statements ||= DropIndexStatements.new(command_output)
    end

    private

    def command_output
      output = Kernel.system('pt-duplicate-key-checker')
      raise InvalidScanError unless $?.exitstatus.zero?
      output
    end
  end
end
