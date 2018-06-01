module Bottington
  class Request < Rack::Request
    attr_accessor :user, :chat, :event

    def bot_path
    end

    def messenger_platform
      self.path.gsub()
    end
  end
end
