module Bottington
  class Bot < BaseBot
    def initialize(request)
      @request = request
      @bot_request = @request.bot_request
    end

    def call
      # TODO: it's example how use this method
      msg = @bot_request.message
      if msg.type == 'command'

      else

      end

      reply :type, response_text, keyboard, @request
    end
  end
end
