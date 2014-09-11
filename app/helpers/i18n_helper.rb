module I18nHelper
	def herokuEnv?
		ENV['RAILS_ENV'] == 'qa' || ENV['RAILS_ENV'] == 'staging' || ENV['RAILS_ENV'] == 'production'
	end
end
