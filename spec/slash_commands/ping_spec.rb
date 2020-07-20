# frozen_string_literal: true

require 'spec_helper'

describe 'slash_commands/ping' do
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
          command: '/ping',
          text: '`',
          channel_id: 'channel',
          channel_name: 'channel_name',
          user_id: 'user_id',
          team_id: 'team_id',
          token: 'deprecated'
        }
      end

      it 'returns pong' do
        expect_any_instance_of(Logger).to receive(:info).with('Received a ping, responding with pong.')
        post '/api/slack/command', command
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)).to eq('text' => 'pong')
      end
    end
  end
end
