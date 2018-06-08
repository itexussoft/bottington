require 'singleton'
require 'securerandom'
require_relative "bottington/version"
require_relative 'bottington/messenger_platform_connector'
require_relative 'bottington/request'
require_relative 'bottington/bot_dispatcher'
require_relative 'bottington/adapter/messenger_platform_adapter'
require_relative 'bottington/http_client'
require_relative 'bottington/adapter/telegram'
require_relative 'bottington/adapter/facebook'
require_relative 'bottington/base_bot'
require_relative 'bottington/bot_request'
require_relative 'bottington/user'
require_relative 'bottington/message'
require_relative 'bottington/media'

module Bottington
  class BotMiddleware
    def initialize(app=nil)
      @app = app || lambda { |_| [404, [], []] }
    end

    def call(env)
      request = Rack::Request.new(env)
      body = []
      if request.path.start_with?(Bottington.route_prefix)
        bottington_request = Bottington::MessengerPlatformConnector.instance.bottington_request(Bottington::Request.new(env))
        Bottington::BotDispatcher.instance.dispatch(bottington_request)
        body = verify_facebook_webhook(env)
        return [200, {'Content-Type' => 'application/json'}, body]
      end
      @app.call(env)
    end

    private

    def verify_facebook_webhook(env)
      value = []
      if env['QUERY_STRING'].include?('verify_token')
        env['QUERY_STRING'].split('&').each do |p|
          splitted_param = p.split('=')
          value.push(splitted_param.last) if splitted_param.first == 'hub.challenge'
        end
      end
      value
    end

  end

  class << self
    mattr_accessor :telegram_token
    self.telegram_token = ''

    mattr_accessor :viber_token
    self.viber_token = ''

    mattr_accessor :facebook_token
    self.facebook_token = ''

    mattr_accessor :fb_verify_token
    self.fb_verify_token = 'verify'

    mattr_accessor :route_prefix
    self.route_prefix = '/bottington'
  end

  def self.setup(&block)
    yield self
  end
end
