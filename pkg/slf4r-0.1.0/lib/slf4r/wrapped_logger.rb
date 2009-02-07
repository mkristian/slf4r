require 'abstract_logger_facade'
module Slf4r
  class LoggerFacade4WrappedLogger

    @@logger = nil

    def self.new_logger_facade(name)
      raise "set logger first" unless @@logger
      @@logger
    end

    def self.logger=(logger)
      @@logger = logger
    end
  end

  class LoggerFacade < AbstractLoggerFacade

    def initialize(name)
      super
      @logger = LoggerFacade4WrappedLogger.new_logger_facade(name)
    end

    protected

    def _debug(msg)
      @logger.debug(msg)
    end

    def _info(msg)
      @logger.info(msg)
    end

    def _warn(msg)
      @logger.warn(msg)
    end

    def _error(msg)
      @logger.error(msg)
    end

    public 

    def debug?
      @logger.debug?
    end

    def info?
      @logger.info?
    end

    def warn?
      @logger.warn?
    end

    def error?
      @logger.error?
    end
  end
end
