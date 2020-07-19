# frozen_string_literal: true

class Help < SlackRubyBot::Commands::Base
  HELP = <<~EOS
    ```
    Sample bot that uses slack-ruby-bot-server-events.

    Commands
    --------

    help               - get this helpful message

    ```
  EOS
  def self.call(client, data, _match)
    client.say(channel: data.channel, text: HELP)
    logger.info "HELP: #{client.owner}, user=#{data.user}"
  end
end
