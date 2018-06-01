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
        @request.user = Bottington::User.new({
            id: @request[:message][:from][:id],
            first_name: @request[:message][:from][:first_name],
            last_name: @request[:message][:from][:last_name],
            username: @request[:message][:from][:username]
          })
        @request.message = Bottington::Message.new(build_request_message(@request[:message][:text]))
        @request.media = Bottington::Media.new({
            id: @request[:message][:photo] ? @request[:message][:photo].last[:file_id] : @request[:message][:document][:file_id]
          })

        @request
      end

      def platform_url
        BASIC_TELEGRAM_URL + "/sendMessage"
      end
    end
  end
end
