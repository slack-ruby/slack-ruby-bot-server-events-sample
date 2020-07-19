# frozen_string_literal: true

Mongoid.load!(File.expand_path('../../config/mongoid.yml', __dir__), ENV['RACK_ENV'])

RSpec.configure do |config|
  config.before :suite do
    Mongoid.logger.level = Logger::INFO
    Mongo::Logger.logger.level = Logger::INFO

    Mongoid::Tasks::Database.create_indexes
  end
end
