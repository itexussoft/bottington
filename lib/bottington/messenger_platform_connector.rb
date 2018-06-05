module Bottington
  class MessengerPlatformConnector
    include Singleton

    def bottington_request(request)
      adapter = MessengerPlatformAdapter.lookup_adapter(request)
      adapter.update_request
    end

    def send_bot_response(request, response, type = :text)
      adapter = MessengerPlatformAdapter.lookup_adapter(request)
      Bottington::HttpClient.instance.send(adapter.request_method, adapter.platform_url, adapter.response_body(request.bot_request, response, type))
    end
  end
end
