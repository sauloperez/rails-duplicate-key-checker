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
      analyzer.scan
      generate_migrations
    end

    private

    attr_reader :analyzer

    def generate_migrations
    end
  end
end
