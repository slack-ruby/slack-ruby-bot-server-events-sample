# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('..', __dir__)

ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require

Dir[File.join(File.dirname(__FILE__), 'support', '**/*.rb')].sort.each do |file|
  require file
end

require 'slack-ruby-bot-server/rspec'

require_relative '../app'
