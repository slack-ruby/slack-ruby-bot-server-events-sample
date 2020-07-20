# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

Bundler.require :default

Dir[File.expand_path('config/initializers', __dir__) + '/**/*.rb'].sort.each do |file|
  require file
end

Mongoid.load!(File.expand_path('config/mongoid.yml', __dir__), ENV['RACK_ENV'])

require_relative 'lib/models'
require_relative 'lib/commands'
require_relative 'lib/events'
require_relative 'lib/slash_commands'
