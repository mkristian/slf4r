class Slf4rRailtie < Rails::Railtie

  config.before_configuration do |app|
    #if defined?(Slf4r)
    #  require 'slf4r/ruby_logger' unless defined?(::Slf4r::LoggerFacade)
    #end
    if defined?(Slf4r::LoggerFacade)
      @logger = (Rails.logger = setup_logger(Rails))
      app.config.logger = @logger
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
      
    end
  end

  config.after_initialize do |app|
    unless defined?(Slf4r::LoggerFacade)
      require 'slf4r/wrapped_logger'
      Slf4r::LoggerFacade4WrappedLogger.logger = Rails.logger
      puts "setup slf4r logger wrapper"
    end
  end

  private
  def self.setup_logger(category)
    l = Slf4r::LoggerFacade.new((category == Rails ? "" : "Rails::") + category.to_s)
    (@logger || l).info("setup logger for '#{l.name}")
    l
  end
end
