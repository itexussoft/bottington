module Bottington
  class BotRequest < Struct.new(:user, :message, :media, :chat)
  end
end
