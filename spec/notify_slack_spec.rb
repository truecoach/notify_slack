# frozen_string_literal: true

RSpec.describe NotifySlack, '.notify', :slack do
  let(:webhook_id) { 'id' }
  let(:webhook_url) { "https://hooks.slack.com/services/#{webhook_id}" }
  let(:message) { "test" }

  subject(:response) { NotifySlack.notify(webhook_url, message) }

  it 'correctly structures the request' do
    response

    expect(webhook_requests.first.method).to eq(:post)
    expect(webhook_requests.first.body).to include("text" => "test")
    expect(webhook_requests.first.headers).to include("Content-Type" => "application/json")
  end

  it 'posts the message to the slack webhook' do
    expect(response.status).to eq('200')
    expect(response.body).to eq('OK')
  end

  context 'when given an invalid incoming webhook url' do
    let(:webhook_url) { "https://some.other.domain/services/#{webhook_id}" }

    it 'raises an informative error' do
      expect { response }.to raise_error(
        described_class::Validation::ValidationError,
        /url must be a valid slack incoming webhook/i
      )
    end
  end

  context 'when the hook cannot be found' do
    let(:webhook_url) { "https://hooks.slack.com/services/wrong" }

    it 'returns a not found response' do
      expect(response.status).to eq('404')
      expect(response.body).to eq('Not Found')
    end
  end
end
