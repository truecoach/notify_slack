# frozen_string_literal: true

RSpec.describe NotifySlack, '.notify', :slack do
  let(:webhook_id) { 'id' }
  let(:webhook_url) { "https://hooks.slack.com/services/#{webhook_id}" }
  let(:message) { "test" }

  subject(:response) { NotifySlack.notify(webhook_url, message) }

  it 'posts the message to the slack webhook' do
    expect(response.status).to eq('200')
    expect(response.body).to eq('OK')
  end

  context 'when the hook cannot be found' do
    let(:webhook_url) { "https://hooks.slack.com/services/wrong" }

    it 'returns a not found response' do
      expect(response.status).to eq('404')
      expect(response.body).to eq('Not Found')
    end
  end
end
