# frozen_string_literal: true

require 'pry-byebug'
require 'notify_slack'
require 'webmock/rspec'
require 'json'

require_relative 'support/slack_mock'

WebMock.allow_net_connect!

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  config.include SlackMocks, :slack
end
