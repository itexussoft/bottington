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

    mattr_accessor :platforms
    self.platforms = [
      {telegram_token: ''},
      {viber_token: ''},
      {facebook_token: ''},
    ]
  end

  def self.setup(&block)
    yield self
  end
end
