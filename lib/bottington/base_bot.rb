module Bottington
  class BaseBot
    def call
      raise NotImplementedError
    end

    protected
    def reply(type, msg, request)
      Bottington::MessengerPlatformConnector.instance.send_bot_response(request, msg, type)
    end
  end
end
