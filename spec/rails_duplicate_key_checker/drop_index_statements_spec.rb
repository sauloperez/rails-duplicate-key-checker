require 'spec_helper'

describe RailsDuplicateKeyChecker::DropIndexStatements do
  let(:drop_index_statements) { described_class.new(raw_statements) }

  describe '#parse' do
    subject { drop_index_statements.parse }

    let(:raw_statements) do
      <<-OUTPUT
# index_users_on_deleted is a left-prefix of index_users_on_deleted_and_last_activity_at
# Key definitions:
#   KEY `index_users_on_deleted` (`deleted`),
#   KEY `index_users_on_deleted_and_last_activity_at` (`deleted`,`last_activity_at`),
# Column types:
#         `deleted` tinyint(1) not null default '0'
#         `last_activity_at` datetime default null
# To remove this duplicate index, execute:
ALTER TABLE `teambox_development`.`users` DROP INDEX `index_users_on_deleted`;
      OUTPUT
    end

    it do
      is_expected.to match_array([
        RailsDuplicateKeyChecker::DropIndexStatement.new(
          'teambox_development',
          'users',
          'index_users_on_deleted'
        )
      ])
    end
  end
end
