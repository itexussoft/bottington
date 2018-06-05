require 'addressable'
module Bottington
  class Request < Rack::Request
    attr_accessor :user, :chat, :event

    URL_TEMPLATE = Addressable::Template.new('{scheme}://{host}/{bottington}/{platform}{/bot_path*}{?query*}')

    def bot_path
      URL_TEMPLATE.match(self.url)[:bot_path]
    end

    def messenger_platform
      URL_TEMPLATE.match(self.url)[:platform]
    end
  end
end
