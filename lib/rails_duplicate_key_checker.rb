require 'rails_duplicate_key_checker'
require 'rails_duplicate_key_checker/migration_generator'
require 'active_record'

module RailsDuplicateKeyChecker
  class TableScanner
    class InvalidScanError < StandardError; end

    def initialize(*args)
    end

    def scan
      @command_output = Kernel.system('pt-duplicate-key-checker')
      raise InvalidScanError unless $?.exitstatus.zero?
    end

    def alter_table_statements
    end

    private

  end

  class Checker
    def initialize(table_scanner = TableScanner.new)
      @table_scanner = table_scanner
    end

    def run
      scan_for_duplicate_keys
      generate_migrations
    end

    private

    attr_reader :table_scanner

    def scan_for_duplicate_keys
      table_scanner.scan
    end

    def generate_migrations
    end
  end
end
