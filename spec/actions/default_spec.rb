# frozen_string_literal: true

require 'spec_helper'

describe 'actions/count_letters' do
  include Rack::Test::Methods

  def app
    SlackRubyBotServer::Api::Middleware.instance
  end

  context 'without signature checks' do
    before do
      allow_any_instance_of(Slack::Events::Request).to receive(:verify!)
    end

    let(:action) do
      {
        payload: {
          type: 'global_shortcut',
          token: 'token',
          action_ts: '1595216478.218264',
          team: {
            id: 'T04KB5WQH',
            domain: 'dblockdotorg'
          },
          user: {
            id: 'U04KB5WQR',
            name: 'dblock',
            username: 'dblock',
            team_id: 'T04KB5WQH'
          },
          channel: {
            id: 'C0181T3HTFS',
            name: 'events'
          },
          callback_id: 'shortcut-id',
          response_url: 'url'
        }
      }
    end

    it 'ignores message' do
      post '/api/slack/action', action
      expect(last_response.status).to eq 204
    end
  end
end
