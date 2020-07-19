# frozen_string_literal: true

require 'spec_helper'

describe 'index.html', js: true, type: :feature do
  before do
    ENV['SLACK_CLIENT_ID'] = 'slack-client-id'
    visit '/'
  end
  after do
    ENV.delete 'SLACK_CLIENT_ID'
  end
  it 'includes a link to add to slack with the client id' do
    expect(title).to eq('Slack Ruby Bot Server')
    expect(first('p[id=register] a')['href']).to eq 'https://slack.com/oauth/authorize?scope=bot&client_id=slack-client-id'
  end
end
