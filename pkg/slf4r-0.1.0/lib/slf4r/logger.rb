module Slf4r
  module Logger

    def logger
      @logger ||= LoggerFacade.new(self.class == Class ? name : self.class)
    end

  end
end
