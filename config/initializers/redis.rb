# if Rails.env.development?
#   REDIS = Redis.new(host: 'localhost', port: 6379)
# elsif Rails.env.production?

if ENV["REDISTOGO_URL"]
	uri = URI.parse(ENV["REDISTOGO_URL"])
	REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
