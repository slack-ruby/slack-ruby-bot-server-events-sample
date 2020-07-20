SlackRubyBotServer::Events.configure do |config|
  config.on :action do |action|
    action.logger.info "Received #{action[:payload][:type]}."
    nil
  end
end
