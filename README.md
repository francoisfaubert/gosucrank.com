== README

The following variables need to be set on Heroku when publishing

heroku config:add TWITTER_CONSUMER_KEY=token
heroku config:add TWITTER_CONSUMER_SECRET=token
heroku config:add TWITTER_ACCESS_TOKEN=token
heroku config:add TWITTER_ACCESS_SECRET=token

After first deploy, one must create the tables
heroku run rake db:migrate


In developement, the variables must be in a file in config/local_env.yml

TWITTER_CONSUMER_KEY: token
TWITTER_CONSUMER_SECRET: token
TWITTER_ACCESS_TOKEN: token
TWITTER_ACCESS_SECRET: token
