# frozen_string_literal: true

require 'spec_helper'

describe Help do
  let(:app) { SlackRubyBotServer::Server.new(team: team) }
  let(:client) { app.send(:client) }
  let(:message_hook) { SlackRubyBot::Hooks::Message.new }
  let!(:team) { Fabricate(:team) }
  it 'displays help' do
    expect(client).to receive(:say).with(channel: 'channel', text: Help::HELP)
    message_hook.call(client, Hashie::Mash.new(channel: 'channel', text: "#{SlackRubyBot.config.user} help"))
  end
end
