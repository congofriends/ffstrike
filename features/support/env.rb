require 'cucumber/rails'
Dir[Rails.root.join("features/support/*.rb")].each { |f| require f }
# Capybara.javascript_driver = :webkit

# Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#   DatabaseCleaner.strategy = :truncation
# end

DatabaseCleaner.logger = Rails.logger

Cucumber::Rails::Database.javascript_strategy = :transaction
