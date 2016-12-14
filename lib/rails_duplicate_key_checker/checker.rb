module RailsDuplicateKeyChecker
  class Checker
    def initialize(analyzer = DuplicateKeysAnalyzer.new)
      @analyzer = analyzer
    end

    def run
      alter_table_statements = analyzer.alter_table_statements.parse
      generate_migrations(alter_table_statements)
      nil
    end

    private

    attr_reader :analyzer

    def generate_migrations(statements)
    end
  end
end
