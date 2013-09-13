#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: ffstrike-provision-heroku.sh APP_NAME"
  exit 1
fi

APP_NAME=$1

heroku apps:create --addons mongohq:sandbox $APP_NAME
git push heroku master
heroku run bundle exec rake mongo:seed
heroku run bundle exec rake db:mongoid:create_indexes
heroku ps:scale web=1 -a $APP_NAME

echo "Remember: You'll need a corresponding Facebook app to refer to "
echo "    http://$APP_NAME.herokuapp.com"
