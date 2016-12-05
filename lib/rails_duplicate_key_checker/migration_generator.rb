require 'rails/generators/active_record/migration'

module RailsDuplicateKeyChecker
  class MigrationGenerator < SimpleDelegator
    # ::ActiveRecord::Generators::MigrationGenerator
    def set_local_assigns!
      @migration_template = 'remove_index_migration.rb'
    end
  end
end
