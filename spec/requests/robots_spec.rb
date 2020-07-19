# frozen_string_literal: true

require 'spec_helper'

describe 'Robots.txt', type: :request do
  include Rack::Test::Methods

  def app
    SlackRubyBotServer::Api::Middleware.instance
  end

  it 'can be retrieved' do
    get '/robots.txt'
    expect(last_response.status).to eq 200
    expect(last_response.body).to eq ['User-Agent: *', 'Disallow: /'].join("\n")
  end
end
