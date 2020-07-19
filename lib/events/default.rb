SlackRubyBotServer::Events.configure do |config|
  config.on :event do |event|
    event.logger.info "Received #{event[:type]}, #{event[:event][:type]}."
    { ok: true }
  end
end
