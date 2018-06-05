module Bottington
  module Adapter
    class Facebook < MessengerPlatformAdapter
      def initialize(request)
        @request = request
      end

      def update_request

      end

      def response_body(bot_request, body, type)
        {messaging_type: '', recipient: {id: ''}, message: {text: ''}}
      end

      def platform_url

      end
    end
  end
end
