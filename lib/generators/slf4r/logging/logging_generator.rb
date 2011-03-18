class Slf4r::LoggingGenerator < Rails::Generators::Base
  #source_root File.expand_path('../templates', __FILE__)

  def setup
    source = File.expand_path('../../templates', __FILE__)
    initializer "logging.rb", File.read(File.join(source, "logging.rb"))
    gem 'slf4r', :require => 'slf4r/logging_logger'
    gem "logging"
  end
end
