source 'https://rubygems.org'
source 'https://rails-assets.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.4'

gem 'pg', '0.15.1'

# CSS related gems
gem 'sass-rails', '~> 4.0.0'

gem 'haml-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Include font-awesome, used in many icons
gem 'font-awesome-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-modal-rails'
gem 'rails_serve_static_assets'

# File upload related
# gem "paperclip", "~> 3.0"
gem 'paperclip', github: 'thoughtbot/paperclip'
gem "rmagick"
gem 'pdfkit'
gem 'wkhtmltopdf-binary', "0.9.9"

gem 'activerecord-reset-pk-sequence'

gem 'aws-s3'
gem 'aws-sdk'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

gem 'best_in_place', github: 'bernat/best_in_place'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

gem 'omniauth'
gem 'omniauth-facebook'

# Check test coverage across app
gem 'simplecov', :require => false, :group => :test

# User authentication system
gem 'devise'

# Invitation system
gem 'devise_invitable'

# Geocoding
gem 'geocoder'

# Localizing JavaScript
gem 'i18n-js'

gem 'gon'

group :test, :development do
  gem 'rspec'
  gem 'faker'
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'factory_girl_rails', "~> 4.0"
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-plus'
  gem 'better_errors'
  gem 'assert_difference'
  gem 'jasmine-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'poltergeist'
end

group :production, :staging do
  gem 'rails_12factor'
  gem 'heroku-deflater'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

#Rediculously Responsive Social Sharing Buttons
gem 'rails-assets-RRSSB'

# Memcaching
gem 'dalli'
gem 'memcachier'

gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
