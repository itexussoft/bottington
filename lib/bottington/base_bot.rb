module Bottington
  class BaseBot

    protected
    def reply(request, msg)
      Bottington::MessengerPlatformConnector.instance.send_bot_response(request, msg)
    end
  end
end
