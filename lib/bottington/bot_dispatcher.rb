module Bottington
  class BotDispatcher
    include Singleton

    def dispatch(request)
      route = RoutesRegister.instance.find(request)
      if route
        # верно ли я понял твою задумку, когда ты писал `route.bot.new(request).call` ?
        # как я понял, здесь мы должны сформировать ответ и отправить его в мессенджер
        route.bot.new(request).build_response
      else
        raise IndexError, "there is no mapped bots for #{request.bot_path} path"
      end
    end
  end

  class RoutesRegister
    include Singleton

    def initialize
      @routes = []
      @platfroms_stack = []
    end

    def map(path, bot)
      @routes << Route.new(path, bot, @platfroms_stack.last)
    end

    def platform(*args, &block)
      args.each do |platform|
        @platfroms_stack.push(platform)
        block.call
        @platfroms_stack.pop()
      end
    end

    def find(request)
      @routes.find do |route|
        route.path == request.bot_path && (route.platform.nil? || route.platform == request.platfrom)
      end
    end

    def draw(&block)
      instance_eval &block
    end

  end

  class Route < Struct.new(:path, :bot, :platform);end


  def self.routes
    RoutesRegister.instance
  end
end
