# ffstrike

## How to get started

    brew install mongodb # (on Mac, you will need to install Mongo for the platform you're on)
    git clone git@github.com:gardym/ffstrike.git
    cd ffstrike
    bundle install
    bundle exec rake mongo:start
    bundle exec rails server

Then view [http://localhost:3000](http://localhost:3000) in your browser

## We're using

- Ruby 2
- Rails 4
- Devise + Omniauth-Facebook
- Bootstrap 3
- FontAwesome
- Mongodb
