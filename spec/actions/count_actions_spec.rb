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
          type: 'message_action',
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
          callback_id: 'count-letters',
          message: {
            type: 'message',
            text: 'this is text',
            ts: 'ts'
          },
          response_url: 'url'
        }
      }
    end

    it 'posts an ephemeral message' do
      expect(Faraday).to receive(:post).with(
        'url',
        {
          text: 'The text "this is text" has 12 letter(s).',
          response_type: 'ephemeral'
        }.to_json,
        'Content-Type' => 'application/json'
      )
      post '/api/slack/action', action
      expect(last_response.status).to eq 201
      expect(JSON.parse(last_response.body)).to eq('ok' => true)
    end
  end
end
