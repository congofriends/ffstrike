Ffstrike::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :authentication => :plain,
    :address => "smtp.mailgun.org",
    :port => 587,
    :domain => "ffstrike.mailgun.org",
    :user_name => "postmaster@ffstrike.mailgun.org",
    :password => "53bdbr1f8280"
  }
  config.action_mailer.default_url_options = { :host => "http://shift-engage-staging.herokuapp.com" }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

end
