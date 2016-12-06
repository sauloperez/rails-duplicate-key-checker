require 'rails_duplicate_key_checker/drop_index_statements'
require 'rails_duplicate_key_checker/backend'

module RailsDuplicateKeyChecker
  class DuplicateKeysAnalyzer
    class InvalidScanError < StandardError; end

    def alter_table_statements
      @alter_table_statements ||= DropIndexStatements.new(command_output)
    end

    private

    def command_output
      output = backend.run
      raise InvalidScanError unless backend.success?
      output
    end

    def backend
      Backend.new('teambox_development', 'root')
    end
  end
end
