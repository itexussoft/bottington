module Bottington
  module Adapter
    class MessengerPlatformAdapter
      def self.lookup_adapter(request)
        "#{request.messenger_platform}Adapter".constantize.new(request)
      end

      def update_request
        raise NotImplementedError
      end

      def request_method
        Bottington::HttpClient::HTTP_METHOD_POST
      end

      def platform_url
        nil
      end
    end
  end
end
