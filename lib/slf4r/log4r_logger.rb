require 'log4r'
require 'slf4r/abstract_logger_facade'

module Slf4r
  class LoggerFacade < AbstractLoggerFacade
    
    attr_reader :logger
    
    def initialize(name)
      super
      @logger = ::Log4r::Logger::Repository[name] || ::Log4r::Logger.new(name)
    end

    public 

    def debug?
      @logger.level == 0
    end

    def _debug(msg)
      @logger.debug(msg)
    end

    def info?
      @logger.level <= 1
    end

    def _info(msg)
      @logger.info(msg)
    end

    def warn?
      @logger.level <= 2
    end

    def _warn(msg)
      @logger.warn(msg)
    end

    def error?
      @logger.level <= 3
    end

    def _error(msg)
      @logger.error(msg)
    end
    
  end
end
