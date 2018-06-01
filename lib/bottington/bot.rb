module Bottington
  class Bot < BaseBot
    def initialize(request)
      @request = request
    end

    def build_response_text
      # do something and return response_text

      reply(@request, response_text)
    end
  end
end
