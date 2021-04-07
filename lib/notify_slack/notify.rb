# frozen_string_literal: true

require 'net/http'
require 'json'

module NotifySlack
  Response = Struct.new(:status, :body, keyword_init: true)

  class Notify
    def self.call(...)
      new(...).call
    end
    private_class_method :new

    def initialize(url, message)
      @url = url
      @message = message
    end

    attr_reader :url, :message

    def call
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
  end
end
