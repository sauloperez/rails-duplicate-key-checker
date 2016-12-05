require 'rails-duplicate-key-checker'

module RailsDuplicateKeyChecker
  class Railtie < Rails::Railtie
    railtie_name :rails_duplivate_key_checker

    initializer 'rails_duplivate_key_checker.load' do |app|
    end
  end
end
