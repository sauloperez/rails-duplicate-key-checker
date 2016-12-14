require 'rails/generators/base'
require 'rails/generators/active_record'

module RailsDuplicateKeyChecker
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      def create_migration
      end
    end
  end
end
