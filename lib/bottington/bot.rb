module Bottington
  class Bot < BaseBot
    def initialize(request)
      @request = request
    end

    # метод, в котором будут обрабатываться команды
    # и потом отправляться ответ в мессенджер через reply(request, msg).
    # по сути, здесь будет формироваться body для ответа боту.
    # здесь, потому что на некоторые команды надо будет добавлять кастомную клавиатуру.
    def build_response_text
      # do something and return response_text

      reply(@request, response_text)
    end
  end
end
