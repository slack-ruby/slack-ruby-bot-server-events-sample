# frozen_string_literal: true

require 'capybara/rspec'

Capybara.configure do |config|
  config.app = SlackRubyBotServer::Api::Middleware.instance
  config.server = :webrick
  config.server_port = 9293
end
