Slack Ruby Bot Server Events Sample
===================================

[![Build Status](https://travis-ci.org/slack-ruby/slack-ruby-bot-server-events-sample.svg?branch=master)](https://travis-ci.org/slack-ruby/slack-ruby-bot-server-events-sample)

### What is this?

A sample app based on [slack-ruby-bot-server-sample](https://github.com/slack-ruby/slack-ruby-bot-server-sample) that implements and responds to [Slack Events API](https://api.slack.com/events-api), [Interactive Message Buttons](https://api.slack.com/legacy/message-buttons) and [Slash Commands](https://api.slack.com/interactivity/slash-commands) using the [slack-ruby-bot-server-events](https://github.com/slack-ruby/slack-ruby-bot-server-events) extension.

### Running the Sample

Create `.env` file with the following settings.

```
SLACK_CLIENT_ID=...
SLACK_CLIENT_SECRET=...
SLACK_OAUTH_SCOPE=bot,commands
SLACK_SIGNING_SECRET=...
```

Run `bundle install` and `foreman start`.

### Copyright & License

Copyright [Daniel Doubrovkine](http://code.dblock.org), 2020

[MIT License](LICENSE)
