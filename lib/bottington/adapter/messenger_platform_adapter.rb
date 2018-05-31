module Bottington
  module Adapter
    class MessengerPlatformAdapter
      def bot_request

      end

      protected

      def user
        {
          id: nil,
          first_name: '',
          last_name: '',
          username: ''
        }
      end

      def chat
        {id: nil}
      end

      def command
        {text: ''}
      end

      def message
        {text: ''}
      end

      def photo
        {}
      end

      def document
        {}
      end

      def http_method
        Bottington::HttpClient::HTTP_METHOD_POST
      end

      def url
        nil
      end
    end
  end
end
