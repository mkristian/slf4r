module Logging
  class Logger

    def initialize(name)
      @logger = ::Slf4r::LoggerFacade.new(name)
    end

    class << self
      alias :[] :new
    end
    
    def method_missing(method, *args, &block)
      @logger.send(method, *args, &block) if @logger.respond_to?(method)
    end
  end
end