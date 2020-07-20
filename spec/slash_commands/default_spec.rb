# frozen_string_literal: true

require 'spec_helper'

describe 'slash_commands/default' do
  include Rack::Test::Methods

  def app
    SlackRubyBotServer::Api::Middleware.instance
  end

  context 'without signature checks' do
    before do
      allow_any_instance_of(Slack::Events::Request).to receive(:verify!)
    end

    context 'with a team' do
      let!(:team) { Fabricate(:team) }

      let(:command) do
        {
          command: '/default',
          text: '`',
          channel_id: 'channel',
          channel_name: 'channel_name',
          user_id: 'user_id',
          team_id: 'team_id',
          token: 'deprecated'
        }
      end

      it 'logs the event' do
        expect_any_instance_of(Logger).to receive(:info).with('Received /default.')
        post '/api/slack/command', command
        expect(last_response.status).to eq 204
      end
    end
  end
end
