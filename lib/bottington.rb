require "bottington/version"

module Bottington
  class BotMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      # TODO: check from which messenger we get request
      [status, headers, response_body]
    end
  end

  class << self

    mattr_accessor :telegram_token
    self.telegram_token = ''

    mattr_accessor :viber_token
    self.viber_token = ''

    mattr_accessor :facebook_token
    self.facebook_token = ''
  end

  def self.setup(&block)
    yield self
  end
end
