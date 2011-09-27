module Logging
  class Logger

    def initialize(name)
      @logger = ::Slf4r::Logger.new(name)
    end

    class << self
      alias :[] :new
    end

    def method_missing(method, *args, &block)
      @logger.send(method, *args, &block) if @logger.respond_to?(method)
    end

    def respend_to?(method)
      @logger.respond_to?(method)
    end
  end
end
