module Slf4r
  module Logger

    def logger
      @logger ||= ::Slf4r::LoggerFacade.new(self.class == Class ? name : self.class)
    end

  end
end
