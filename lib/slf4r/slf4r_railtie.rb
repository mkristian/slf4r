class Slf4rRailtie < Rails::Railtie

  # config.before_configuration do |app|
  #   app.config.class.class_eval do
  #     attr_accessor :slf4r
  #   end
  # end

  config.after_initialize do |app|
    if defined?(Slf4r)
      logger = (Rails.logger = setup_logger(Rails.logger, Rails))
      app.config.logger = setup_logger(app.config.logger, Rails.application.class)
      app.config.action_controller.logger = Slf4r::LoggerFacade.new(ActionController)
      app.config.active_record.logger = Slf4r::LoggerFacade.new(ActiveRecord)
      app.config.action_view.logger = Slf4r::LoggerFacade.new(ActionView)
      app.config.action_mailer.logger = Slf4r::LoggerFacade.new(ActionMailer)
      ActiveSupport::Cache::Store.logger = Slf4r::LoggerFacade.new(ActiveSupport::Cache::Store)
      clazz = if logger.instance_variable_get(:@logger).respond_to?(:java_class)
                logger.instance_variable_get(:@logger).java_class 
              else
                logger.instance_variable_get(:@logger).class 
              end
      logger.info("setup slf4r logger categories for #{clazz}")
   else
      require 'slf4r/wrapped_logger'
      logger = (Slf4r::LoggerFacade4WrappedLogger.logger = Rails.logger)
      logger.info("setup slf4r logger wrapper with #{logger.inspect}")
    end
  end

  private
  def self.setup_logger(logger, category)
    l = Slf4r::LoggerFacade.new(category)
    real_logger = l.instance_variable_get(:@logger)
    # adjust log level it the logger implementation allows it
    if logger && real_logger.respond_to?(:level)
      real_logger.level = logger.level
    end
    l
  end
end
