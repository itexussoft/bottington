require "bottington/version"
require 'singleton'
require 'securerandom'

module Bottington
  class BotMiddleware
    def initialize(app=nil)
      @app = app || lambda { |_| [404, [], []] }
    end

    def call(env)
      request = Rack::Request.new(env)
      if request.path.start_with?(Bottington.route_prefix)
        bottington_request = Bottington::MessengerPlatformConnector.instance.bottington_request(Bottington::Request.new(env))
        Bottington::BotDispatcher.instance.dispatch(bottington_request)
        return [200, [], []]
      end
      @app.call(env)
    end
  end

  class << self

    mattr_accessor :telegram_token
    self.telegram_token = ''

    mattr_accessor :viber_token
    self.viber_token = ''

    mattr_accessor :facebook_token
    self.facebook_token = ''

    mattr_accessor :route_prefix
    self.route_prefix = '/bottington'
  end

  def self.setup(&block)
    yield self
  end
end
