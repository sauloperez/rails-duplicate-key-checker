require 'rails_duplicate_key_checker'
require 'rails_duplicate_key_checker/migration_generator'
require 'rails_duplicate_key_checker/duplicate_keys_analyzer'
require 'active_record'

module RailsDuplicateKeyChecker
  class Checker
    def initialize(analyzer = DuplicateKeysAnalyzer.new)
      @analyzer = analyzer
    end

    def run
      alter_table_statements = analyzer.alter_table_statements
      generate_migrations(alter_table_statements)
    end

    private

    attr_reader :analyzer

    def generate_migrations(statements)
    end
  end
end
