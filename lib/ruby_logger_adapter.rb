class Logger

  def initialize(*args)
    @logger = ::Slf4r::LoggerFacade.new(:root)
  end
  
  def method_missing(method, *args, &block)
    @logger.send(method, *args, &block) if @logger.respond_to?(method)
  end
end
