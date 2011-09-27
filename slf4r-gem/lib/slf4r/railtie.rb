module Slf4r
  class Railtie < Rails::Railtie

    initializer "set_servlet_logger", :after => :initialize_logger do |app|
      if defined?(Slf4r::LoggerFacade)
        @logger = Slf4r::LoggerFacade.new("Rails::Setup")
        @logger.info {
          l = @logger.instance_variable_get('@logger'.to_sym)
          logger_name = l.respond_to?(:java_class) ? l.java_class : l.class
          "setup slf4r logger #{logger_name}"
        }
        app.config.logger = Rails.logger = setup_logger(Rails)
        app.config.action_controller.logger = setup_logger(ActionController)
        app.config.active_record.logger = setup_logger(ActiveRecord)
        app.config.action_view.logger = setup_logger(ActionView) if app.config.action_view.respond_to? :logger=
          app.config.action_mailer.logger = setup_logger(ActionMailer)
        ActiveSupport::Cache::Store.logger = setup_logger(ActiveSupport::Cache::Store)
        clazz = if @logger.instance_variable_get(:@logger).respond_to?(:java_class)
                  @logger.instance_variable_get(:@logger).java_class 
                else
                  @logger.instance_variable_get(:@logger).class 
                end
      else
        require 'slf4r/wrapped_logger'
        l = Slf4r::LoggerFacade4WrappedLogger.logger = Rails.logger
        l.info "setup slf4r logger wrapper"
      end
    end

    private
    def self.setup_logger(category)
      _logger = Slf4r::LoggerFacade.new((category == Rails ? "" : "Rails::") + category.to_s)
      @logger.info("setup logger for '#{_logger.name}'") if @logger
      _logger
    end
  end
end
