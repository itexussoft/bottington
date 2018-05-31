module Bottington
  class BaseBot
    def reply

    end

    protected
    def answer_with(answer)
      Bottington::MessengerPlatformConnector.new(answer).send_bot_response
    end

    def keyboard

    end
  end
end
