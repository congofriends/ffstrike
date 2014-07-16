require 'sidekiq'
require 'sidekiq/web'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDISTOGO_URL"] }

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=50"
    ActiveRecord::Base.establish_connection
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDISTOGO_URL"] }
end


Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["FOTCadmin", ENV["SIDEKIQ_PASS"]]
end
