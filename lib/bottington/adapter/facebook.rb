module Bottington
  module Adapter
    class Facebook < MessengerPlatformAdapter
      MESSAGING_TYPE = 'RESPONSE'
      NOTIFICATION_TYPE = 'REGULAR'

      def initialize(request)
        @request = request
      end

      def update_request
        params = @request.params
        @bot_request = @request.bot_request = Bottington::BotRequest.new()
        fb_response = params['entry'][0]['messaging'][0]
        if params.present? && fb_response['delivery'].nil?
          @bot_request.user = Bottington::User.new(fb_response['sender']['id'], '', '', '')
          msg = build_request_message(fb_response['message']['text'])
          @bot_request.message = Bottington::Message.new(
            fb_response['message']['mid'],
            msg[:text],
            msg[:type]
          )
          attachments = fb_response['message']['attachments']
          @bot_request.media = Bottington::Media.new(
            fb_response['message']['mid'],
            attachments ? attachments['payload']['url'] : ''
          )
        end

        @request
      end

      def response_body(bot_request, body, type)
        {
          messaging_type: MESSAGING_TYPE,
          recipient: {
            id: bot_request.user ? bot_request.user.id : nil,
          },
          message: {
            text: body
          },
          notification_type: NOTIFICATION_TYPE
        }
      end

      def platform_url
        "https://graph.facebook.com/v2.6/me/messages?access_token=#{Bottington.facebook_token}"
      end
    end
  end
end
