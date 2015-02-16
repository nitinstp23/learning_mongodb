require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "action_controller/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module DemoMongoService
  class Application < Rails::Application
    config.mongoid.logger = Logger.new($stdout, :warn)
  end
end
