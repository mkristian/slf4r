require 'logging'
require 'slf4r/abstract_logger_facade'

module Slf4r
  class LoggerFacade < AbstractLoggerFacade

    attr_reader :logger

    def initialize(name)
      super
      log_name = nil
      name.to_s.split("::").each do |n|
        if log_name
          log_name += "::#{n}"
        else
          log_name = n
        end
        @logger = ::Logging::Logger.new(log_name)
      end
    end

    private

    def log(type, msg)
      @logger.add(type, msg)
    end

    protected

    def _debug(msg)
      log(0, msg)
    end

    def _info(msg)
      log(1, msg)
    end

    def _warn(msg)
      log(2, msg)
    end

    def _error(msg)
      log(3, msg)
    end

    def _fatal(msg)
      log(4, msg)
    end

    public

    def debug?
      @logger.level == 0
    end

    def info?
      @logger.level <= 1
    end

    def warn?
      @logger.level <= 2
    end

    def error?
      @logger.level <= 3
    end

    def fatal?
      @logger.level <= 4
    end
  end
end
