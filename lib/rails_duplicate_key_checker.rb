require 'rails_duplicate_key_checker'
require 'rails_duplicate_key_checker/migration_generator'
require 'active_record'

module RailsDuplicateKeyChecker
  class DropIndexStatements
    def initialize(raw_statements)
      @raw_statements = raw_statements
    end
  end

  class DuplicateKeysAnalyzer
    class InvalidScanError < StandardError; end

    def scan
      @command_output = Kernel.system('pt-duplicate-key-checker')
      raise InvalidScanError unless $?.exitstatus.zero?
    end

    def alter_table_statements
      DropIndexStatements.new(command_output)
    end

    private

    attr_reader :command_output
  end

  class Checker
    def initialize(analyzer = DuplicateKeysAnalyzer.new)
      @analyzer = analyzer
    end

    def run
      analyzer.scan
      generate_migrations
    end

    private

    attr_reader :analyzer

    def generate_migrations
    end
  end
end
