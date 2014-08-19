require 'cucumber/rails'
require 'capybara/poltergeist'

Dir[Rails.root.join("features/support/*.rb")].each { |f| require f }
# Capybara.javascript_driver = :webkit

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :js_errors => false)
end
Capybara.javascript_driver = :poltergeist
#Comment "Capybara.javascript_driver = :poltergeist" to remove headless driver

# Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#   DatabaseCleaner.strategy = :truncation
# end

DatabaseCleaner.logger = Rails.logger

Cucumber::Rails::Database.javascript_strategy = :transaction
