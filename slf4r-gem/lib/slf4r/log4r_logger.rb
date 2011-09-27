require 'log4r'
require 'slf4r/abstract_logger'

module Slf4r
  class Logger < AbstractLogger

    attr_reader :logger

    def initialize(name)
      super
      @logger = ::Log4r::Logger::Repository[name] || ::Log4r::Logger.new(name)
    end

    public

    def debug?
      @logger.level == Log4r::DEBUG
    end

    def _debug(msg)
      @logger.debug(msg)
    end

    def info?
      @logger.level <= Log4r::INFO
    end

    def _info(msg)
      @logger.info(msg)
    end

    def warn?
      @logger.level <= Log4r::WARN
    end

    def _warn(msg)
      @logger.warn(msg)
    end

    def error?
      @logger.level <= Log4r::ERROR
    end

    def _error(msg)
      @logger.error(msg)
    end

    def fatal?
      @logger.level <= Log4r::FATAL
    end

    def _fatal(msg)
      @logger.fatal(msg)
    end

  end
end
