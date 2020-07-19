# frozen_string_literal: true

require 'spec_helper'

describe 'events/member_joined_channel' do
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

      let(:event) do
        {
          token: 'deprecated',
          api_app_id: 'A19GAJ72T',
          event: {
            type: 'member_joined_channel',
            team: team.team_id,
            user: 'user_id',
            channel: 'channel_id',
            message_ts: '1547842100.001400'
          },
          type: 'event_callback',
          event_id: 'EvFGTNRKLG',
          event_time: 1_547_842_101,
          authed_users: ['U04KB5WQR']
        }
      end

      let(:user) do
        { user: { name: 'Bob' } }
      end

      let(:channel) do
        { channel: { name: 'random' } }
      end

      before do
        expect_any_instance_of(Slack::Web::Client).to receive(:users_info).with(user: 'user_id').and_return(user)
        expect_any_instance_of(Slack::Web::Client).to receive(:conversations_info).with(channel: 'channel_id').and_return(channel)
      end

      it 'posts a welcome message' do
        expect_any_instance_of(Slack::Web::Client).to receive(:chat_postMessage).with(
          channel: 'channel_id', text: 'Welcome Bob to random!'
        )

        post '/api/slack/event', event
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)).to eq('ok' => true)
      end
    end
  end
end
