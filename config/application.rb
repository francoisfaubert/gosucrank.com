
require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  #Bundler.require(:default, :assets, Rails.env)
end

# Thank you to https://github.com/uq-eresearch/miletus/blob/master/config/application.rb for this sample file
# Monkey-patch Rails to handle the lack of database.yml
class Rails::Application::Configuration

  def database_configuration
    # There is no config file, so manufacture one
    config = {
      'test' => 'sqlite3://localhost/:memory:',
      #'development' => ENV['DATABASE_URL'],
      'production' => ENV['DATABASE_URL']
    }
    config.each do |key, value|
      env_config = get_database_environment_from_database_url(value)
      if env_config.nil?
        config.delete(key)
      else
        config[key] = env_config
      end
    end

    config['development'] = {
      'adapter' => 'sqlite3',
      'database' => 'db/development.sqlite3',
      'pool' => 5,
      'timeout' => 5000
    }

    config
  end

  def get_database_environment_from_database_url(db_url)
    # Based on how Heroku do it: https://gist.github.com/1059446
    begin
      uri = URI.parse(db_url)

      return {
        'adapter' => uri.scheme == "postgres" ? "postgresql" : uri.scheme,
        'database' => (uri.path || "").split("/")[1],
        'username' => uri.user,
        'password' => uri.password,
        'host' => uri.host,
        'port' => uri.port
      }
    rescue URI::InvalidURIError
      nil
    end
  end

end


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Crank
  class Application < Rails::Application

    # This application requires a file named config/local_env.yml where
    # all API keys and token are stored. This file _is not versioned_
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
  end
end
