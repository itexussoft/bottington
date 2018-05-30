# require 'faraday'
module Bottington
  class HttpClient
    include Singleton



    def initialize
      @connection = Faraday.new(nil, {request: {timeout: 20}})
    end

    def method_missing(method_name, *args, &block)
      # if @@mimic_methods.include?(method_name.to_sym)
      #   do_call(method_name, *args, &block)
      # else
      #   raise ArgumentError.new("Method `#{m}` doesn't exist.")
      # end
    end

    def respond_to_missing?(method_name, include_private = false)
      # @@mimic_methods.include?(method_name.to_sym) || super
    end

    private

    def do_call()

    end
  end
end
