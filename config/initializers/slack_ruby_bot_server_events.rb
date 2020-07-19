# frozen_string_literal: true

SlackRubyBotServer::Events.configure do |config|
  config.signing_secret ||= ENV['SLACK_SIGNING_SECRET']
  config.signature_expires_in ||= 300
end
