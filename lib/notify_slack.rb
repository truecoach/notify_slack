# frozen_string_literal: true

require_relative 'notify_slack/notify'

module NotifySlack
  class << self
    def notify(url, message)
      Notify.call(url, message)
    end
  end
end
