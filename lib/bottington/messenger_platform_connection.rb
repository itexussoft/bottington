module Bottington
  class MessengerPlatformConnector
    def initialize(params)
      @params = params
    end

    def build_bot_request
      # TODO: choose messenger adapter
    end

    def send_bot_response
      Bottington::HttpClient.instance.send(@params[:http_method], @params[:url], @params.except(:http_method, :url))
    end
  end
end
