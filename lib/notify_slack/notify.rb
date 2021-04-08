# frozen_string_literal: true

require 'net/http'
require 'json'

require_relative 'validation'

module NotifySlack
  Response = Struct.new(:status, :body, keyword_init: true)

  class Notify
    include NotifySlack::Validation

    def self.call(...)
      new(...).call
    end
    private_class_method :new

    def initialize(url, message)
      @url = url
      @message = message
    end

    validates :validate_valid_url

    attr_reader :url, :message

    def call
      validate!

      Response.new(
        status: response.code,
        body: response.body,
      )
    end

    private

    def response
      return @response if defined?(@response)

      @response = Net::HTTP.post(uri, params.to_s, headers)
    end

    def params
      JSON.generate({ text: message })
    end

    def headers
      { 'Content-Type' => 'application/json' }
    end

    def uri
      @uri ||= URI.parse(url)
    end

    def validate_valid_url
      return if url.match?(%r{^https://hooks.slack.com/services/.+})

      errors.add(:url, "must be a valid Slack incoming webhook")
    end
  end
end
