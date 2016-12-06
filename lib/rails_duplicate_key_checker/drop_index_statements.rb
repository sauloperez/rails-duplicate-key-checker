module RailsDuplicateKeyChecker
  class DropIndexStatement
    attr_reader :database, :table, :index

    def initialize(database, table, index)
      @database = database
      @table = table
      @index = index
    end

    def ==(other)
      other.database == database &&
        other.table == table &&
        other.index == index
    end
  end

  class DropIndexStatements
    DROP_INDEX_REGEX =
      %r{\AALTER TABLE `(?<database>\w+)`.`(?<table>\w+)` DROP INDEX `(?<index>\w+)`;}

    def initialize(raw_statements)
      raw_statements = StringIO.new(raw_statements)
      @statements = find_statements(raw_statements)
    end

    def parse
      statements.map do |line|
        match = line.match(DROP_INDEX_REGEX)
        DropIndexStatement.new(match[:database], match[:table], match[:index])
      end
    end

    private

    attr_reader :statements

    def find_statements(raw_statements)
      raw_statements.readlines.select do |line|
        line.match(DROP_INDEX_REGEX)
      end
    end
  end
end
