module Slf4r
  class AbstractLoggerFacade

    protected

    def format(exception)
      (": #{exception.message}:\n\t#{exception.backtrace.join("\n\t") if exception.backtrace }") if exception
    end

    def _debug(msg)
      raise NotImplementedError
    end

    def _info(msg)
      raise NotImplementedError
    end

    def _warn(msg)
      raise NotImplementedError
    end

    def _error(msg)
      raise NotImplementedError
    end

    def _fatal(msg)
      raise NotImplementedError
    end

    public

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def debug?
      raise NotImplementedError
    end

    def debug(msg = nil, exception = nil)
      if(debug?)
        msg, exception = yield if block_given?
        _debug("#{msg}#{format(exception)}")
      end
    end

    def info?
      raise NotImplementedError
    end

    def info(msg = nil, exception = nil)
      if(info?)
        msg, exception = yield if block_given?
        _info("#{msg}#{format(exception)}")
      end
    end

    def warn?
      raise NotImplementedError
    end

    def warn(msg = nil, exception = nil)
      if(warn?)
        msg, exception = yield if block_given?
        _warn("#{msg}#{format(exception)}")
      end
    end

    def error?
      raise NotImplementedError
    end

    def error(msg = nil, exception = nil)
      if(error?)
        msg, exception = yield if block_given?
        _error("#{msg}#{format(exception)}")
      end
    end

    def fatal?
      raise NotImplementedError
    end

    def fatal(msg = nil, exception = nil)
      if(fatal?)
        msg, exception = yield if block_given?
        _fatal("#{msg}#{format(exception)}")
      end
    end
  end
end
