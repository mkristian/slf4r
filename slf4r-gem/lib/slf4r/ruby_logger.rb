require 'logger'
require 'slf4r/abstract_logger'

module Slf4r
  class RubyLogger

    @@file = STDOUT
    @@datetime_format = "%Y-%m-%d %H:%M:%S "

    def self.new_logger(name)
      @name = name
      @logger = ::Logger.new(@@file)
      @@level = ::Logger::DEBUG unless self.class_variable_defined?(:@@level)
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

  class Logger < AbstractLogger

    def initialize(name)
      super
      @logger = RubyLogger.new_logger(name)
    end

    private

    def log(type, msg)
      @logger.add(type, "(#{@name}) " + msg, @name)
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

    def _fatal(msg)
      log(::Logger::FATAL, msg)
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

    def fatal?
      @logger.fatal?
    end
  end
end
