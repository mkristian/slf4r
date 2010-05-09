module Log4r
  class Logger

    def initialize(_fullname, _level=nil, _additive=true, _trace=false)
      @logger = ::Slf4r::LoggerFacade.new(_fullname)
    end

    def method_missing(method, *args, &block)
      @logger.send(method, *args, &block) if @logger.respond_to?(method)
    end

    def respend_to?(method)
      @logger.respond_to?(method)
    end
  end
end
