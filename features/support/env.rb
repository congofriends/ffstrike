require 'cucumber/rails'
Dir[Rails.root.join("features/support/*.rb")].each { |f| require f }
# Capybara.javascript_driver = :webkit

# Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#   DatabaseCleaner.strategy = :truncation
# end

DatabaseCleaner.logger = Rails.logger

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    # EventType.destroy_all
    # EventType.reset_pk_sequence
    # EVENT_DESCRIPTIONS["event_type"].keys.each { |key| EventType.create(name: key.gsub(/_/, ' ').camelize) }
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  # config.before(:each) do
  #   DatabaseCleaner.start
  # end

  # config.after(:each) do
  #   DatabaseCleaner.clean
  # end

end
