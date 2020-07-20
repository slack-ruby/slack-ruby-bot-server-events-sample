SlackRubyBotServer::Events.configure do |config|
  config.on :action, 'message_action', 'count-letters' do |action|
    payload = action[:payload]
    response_url = payload[:response_url]
    message = payload[:message]

    action.logger.info "Counting letters in \"#{message[:text]}\"."

    Faraday.post(response_url, {
      text: "The text \"#{message[:text]}\" has #{message[:text].size} letter(s).",
      response_type: 'ephemeral'
    }.to_json, 'Content-Type' => 'application/json')

    { ok: true }
  end
end
