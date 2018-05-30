module Bottington
  class MessengerPlatformConnector
    def initialize(params)
      @params = params
    end

    def build_bot_request
      # TODO: choose messenger adapter
    end

    def send_bot_response
      # TODO: send response via HttpClient
    end
  end
end
