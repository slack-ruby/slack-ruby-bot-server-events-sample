# frozen_string_literal: true

require 'spec_helper'

describe 'events/member_left_channel' do
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
            type: 'member_left_channel',
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

      it 'logs the event' do
        expect_any_instance_of(Logger).to receive(:info).with('Received event_callback, member_left_channel.')
        post '/api/slack/event', event
        expect(last_response.status).to eq 201
        expect(JSON.parse(last_response.body)).to eq('ok' => true)
      end
    end
  end
end
