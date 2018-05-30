module Bottington
  module Adapter
    class Telegram < MessengerPlatformAdapter
      def initialize(params)
        @params = params
      end

      def bot_request
        {
          chat: chat,
          user: user,
          photo: photo,
          document: document,
          command: command
        }
      end

      protected

      def user
        {
          id: @params[:message][:from][:id],
          first_name: @params[:message][:from][:first_name],
          last_name: @params[:message][:from][:last_name],
          username: @params[:message][:from][:username]
        }
      end

      def chat
        {id: @params[:message][:chat][:id]}
      end

      def command
        {text: @params[:message][:text]}
      end

      def message

      end

      def photo
        if @params[:message][:photo]
          {id: @params[:message][:photo].last[:file_id]}
        else
          {}
        end
      end

      def document
        if @params[:message][:document]
          {id: @params[:message][:document][:file_id]}
        else
          {}
        end
      end
    end
  end
end
