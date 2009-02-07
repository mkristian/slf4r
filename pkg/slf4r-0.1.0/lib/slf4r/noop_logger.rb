module Slf4r
  class LoggerFacade

    def initialize(name)
      @name = name
    end

    public 

    attr_reader :name
    
    def debug?
      false
    end

    def debug(msg = nil, exception = nil)
    end

    def info?
      false
    end

    def info(msg = nil, exception = nil)
    end

    def warn?
      false
    end

    def warn(msg = nil, exception = nil)
    end

    def error?
      false
    end

    def error(msg = nil, exception = nil)
    end
  end
end
