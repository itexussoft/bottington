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
end
