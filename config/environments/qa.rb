Ffstrike::Application.configure do
  ENV['FACEBOOK_ID'] = '426624144117081'
  ENV['FACEBOOK_APP_SECRET'] = 'da81b9d419f0dcce05cc2d370411364f'  

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :authentication => :plain,
    :address => "smtp.mailgun.org",
    :port => 587,
    :domain => "ffstrike.mailgun.org",
    :user_name => "postmaster@ffstrike.mailgun.org",
    :password => "53bdbr1f8280"
  }
  config.action_mailer.default_url_options = { :host => "http://rally-qa.herokuapp.com" }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

end
