module Bottington
  module Adapter
    class Telegram < MessengerPlatformAdapter
      BASIC_TELEGRAM_URL = "https://api.telegram.org/bot#{Bottington.telegram_token}"
      GET_FILE_URL = "#{BASIC_TELEGRAM_URL}/getFile?file_id="
      DOWNLOAD_FILE_URL = "https://api.telegram.org/file/bot#{Bottington.telegram_token}"

      def initialize(request)
        @request = request
      end

      def update_request
        # we need separated key for our bot request data.
        # in other case we can rewrite any keys from original request
        @bot_request = @request.bot_request = Bottington::BotRequest.new
        @bot_request.user = Bottington::User.new(
          @request[:message][:from][:id],
          @request[:message][:from][:first_name],
          @request[:message][:from][:last_name],
          @request[:message][:from][:username]
        )

        @bot_request.chat = Bottington::Chat.new(@request[:message][:chat][:id])

        msg = build_request_message(@request[:message][:text])
        @bot_request.message = Bottington::Message.new(msg[:text], msg[:type])

        media_id = @request[:message][:photo] ? @request[:message][:photo].last[:file_id] : @request[:message][:document][:file_id]
        @bot_request.media = Bottington::Media.new(
          media_id,
          GET_FILE_URL + media_id
        )

        @request
      end

      def response_body(bot_request, body, type)
        {chat_id: bot_request.chat.id, text: body, parse_mode: type}
      end

      def platform_url
        BASIC_TELEGRAM_URL + "/sendMessage"
      end
    end
  end
end
