module Slf4r
  module LoggerModule

    def logger
      @logger ||= ::Slf4r::LoggerFacade.new(self.class == Class ? name : self.class)
    end

  end
end
