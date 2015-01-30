## README

## Techonology

This project uses :

- Ruby on Rails
- Standard rails SASS
- External crons scripts

## Development

In developement, the variables must be in a file in config/local_env.yml

~~~ rb
TWITTER_CONSUMER_KEY: token
TWITTER_CONSUMER_SECRET: token
TWITTER_ACCESS_TOKEN: token
TWITTER_ACCESS_SECRET: token
~~~

Just running `rail server` after migrating the database and install the app bundle will launch everything needed to run the website. It runs locally on Sqlite.

## Deploying

This is explecitely set up to run on Heroku on 1 dyno and Heroku Postgres.

The following variables need to be set on Heroku when first publishing the website:

~~~ sh
heroku config:add TWITTER_CONSUMER_KEY=token
heroku config:add TWITTER_CONSUMER_SECRET=token
heroku config:add TWITTER_ACCESS_TOKEN=token
heroku config:add TWITTER_ACCESS_SECRET=token
~~~

After first deploy, one must create the tables

~~~ sh
heroku run rake db:migrate
~~~
