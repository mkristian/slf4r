class Logger

  def initialize(*args)
    @logger = ::Slf4r::LoggerFacade.new(:root)
  end

  def debug(msg, &block)
    @logger.debug(msg, &block)
  end

  def info(msg, &block)
    @logger.info(msg, &block)
  end

  def warn(msg, &block)
    @logger.warn(msg, &block)
  end

  def error(msg, &block)
    @logger.error(msg, &block)
  end

  def method_missing(method, *args, &block)
    @logger.send(method, *args, &block) if @logger.respond_to?(method)
  end
end
