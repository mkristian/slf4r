require 'logger.rb'
require 'slf4r/abstract_logger_facade'

module Slf4r
  class LoggerFacade4RubyLogger
    
    @@level = ::Logger::INFO
    @@file = STDERR
    @@datetime_format = "%Y-%m-%d %H:%M:%S "

    def self.new_logger_facade(name)
      @name = name
      @logger = ::Logger.new(@@file)
      @logger.level = @@level
      @logger.datetime_format = @@datetime_format
      @logger
    end

    def self.level=(level)
      @@level = level.instance_of?(Fixnum) ? level : 
        ::Logger.get_const(level.to_s.upcase)
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

    public 

    def debug?
      @logger.debug?
    end

    def _debug(msg)
      log(::Logger::DEBUG, msg)
    end

    def info?
      @logger.info?
    end

    def _info(msg)
      log(::Logger::INFO, msg)
    end

    def warn?
      @logger.warn?
    end

    def _warn(msg)
      log(::Logger::WARN, msg)
    end

    def error?
      @logger.error?
    end

    def _error(msg)
      log(::Logger::ERROR, msg)
    end
  end
end
