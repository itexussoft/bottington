module Bottington
  class BaseBot
    def reply

    end

    protected
    def answer_with(answer)
      render json: answer
    end
  end
end
