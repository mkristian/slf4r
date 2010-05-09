require 'logger'
require 'slf4r/abstract_logger_facade'

module Slf4r
  class LoggerFacade4RubyLogger

    @@file = STDERR
    @@datetime_format = "%Y-%m-%d %H:%M:%S "

    def self.new_logger_facade(name)
      @name = name
      @logger = ::Logger.new(@@file)
      @@level = ::Logger::INFO unless self.class_variable_defined?(:@@level)
      @logger.level = @@level
      @logger.datetime_format = @@datetime_format
      @logger
    end

    def self.level=(level)
      @@level = level.instance_of?(Fixnum) ? level :
        ::Logger.const_get(level.to_s.upcase)
    end

    def self.datetime_format=(format)
      @@datetime_format = format
    end

    def self.file=(file)
      @@file = file
    end
  end

  class LoggerFacade < AbstractLoggerFacade

    def initialize(name)
      super
      @logger = LoggerFacade4RubyLogger.new_logger_facade(name)
    end

    private

    def log(type, msg)
      @logger.add(type, msg, @name)
    end

    protected

    def _debug(msg)
      log(::Logger::DEBUG, msg)
    end

    def _info(msg)
      log(::Logger::INFO, msg)
    end

    def _warn(msg)
      log(::Logger::WARN, msg)
    end

    def _error(msg)
      log(::Logger::ERROR, msg)
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
