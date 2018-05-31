module Bottington
  class Bot < BaseBot
    def initialize(params)
      @http_method = params[:http_method]
      @url = params[:url]
      @params = params.except(:http_method, :url)
    end

    def reply
      #  answer = do something
      
      answer[:url] = @url
      answer[:http_method] = @http_method
      answer_with(answer)
    end

    private

    def keyboard

    end
  end
end
