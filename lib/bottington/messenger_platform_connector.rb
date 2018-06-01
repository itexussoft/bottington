module Bottington
  class MessengerPlatformConnector
    include Singleton

    def bottington_request(request)
      adapter = MessengerPlatformAdapter.lookup_adapter(request)
      adapter.update_request
    end

    def send_bot_response(request, response_body)
      adapter = MessengerPlatformAdapter.lookup_adapter(request)
      Bottington::HttpClient.instance.send(adapter.request_method, adapter.platform_url, response_body)
    end
  end
end
