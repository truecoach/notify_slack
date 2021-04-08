# frozen_string_literal: true

module SlackMocks
  extend RSpec::SharedContext

  let(:webhook_id) { 'exists' }
  let(:webhook_requests) { [] }

  before(:each) do
    stub_request(:post, %r{https://hooks.slack.com/services/.*}).to_return do |request|
      webhook_requests << OpenStruct.new(
        body: JSON.parse(request.body),
        headers: request.headers,
        method: request.method,
      )

      base_path = File.basename(request.uri.path)

      if base_path == webhook_id
        next OpenStruct.new(status: 200, body: "OK", headers: request.headers)
      end

      OpenStruct.new(status: 404, body: "Not Found", headers: request.headers)
    end
  end
end
