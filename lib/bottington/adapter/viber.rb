module Bottington
  module Adapter
    class Viber < MessengerPlatformAdapter
      def initialize(request)
        @request = request
      end

      def update_request
        @bot_request = @request.bot_request = Bottington::BotRequest.new
        @bot_request.user = Bottington::User.new(
          @request[:sender][:id],
          @request[:sender][:name],
          ''
        )

        @bot_request.chat = Bottington::Chat.new

        msg = build_request_message(@request[:message][:text])
        @bot_request.message = Bottington::Message.new(msg[:text], msg[:type])
        @bot_request.media = Bottington::Media.new(@request[:message_token], @request[:message][:media])
      end

      def response_body(bot_request, body, type)
        {
          auth_token: Bottington.viber_token,
          receiver: @request.bot_request.user.id,
          type: type,
          text: body
        }
      end

      def platform_url
        'https://chatapi.viber.com/pa/send_message'
      end
    end
  end
end
