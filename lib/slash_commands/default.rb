SlackRubyBotServer::Events.configure do |config|
  config.on :command do |command|
    command.logger.info "Received #{command[:command]}."
    nil
  end
end
