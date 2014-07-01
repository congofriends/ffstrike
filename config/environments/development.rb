Ffstrike::Application.configure do
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  if Rails.env.development? && File.exists?('.env')
    File.new('.env').each do |line|
      var, val = line.split('=').map(&:strip)
      ENV[var] = val
    end
  end

  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => { :bucket => ENV['AWS_BUCKET'],
                         :access_key_id => ENV['AWS_ACCESS_KEY'],
                         :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'] },
    :path => 'attachments/:id/:style.:extension'
  }

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.action_mailer.default_url_options = { :host => "http://shift-engage-qa.herokuapp.com" }
  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.cache_store = :dalli_store

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log


  # SIDEKIQ CONFIG
  # config.queue = ActiveSupport::Queue.new
  # config.action_mailer.queue = Sidekiq::Client::Queue.new

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

	#imagemagick
	Paperclip.options[:command_path] = "/usr/local/bin/"
end
