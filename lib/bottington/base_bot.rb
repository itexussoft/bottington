module Bottington
  class BaseBot
    def call
      raise NotImplementedError
    end

    protected
    def reply(type, msg, keyboard, request)
      Bottington::MessengerPlatformConnector.instance.send_bot_response(request, msg)
    end
  end
end
