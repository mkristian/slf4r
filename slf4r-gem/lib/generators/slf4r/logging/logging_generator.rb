class Slf4r::LoggingGenerator < Rails::Generators::Based

  def setup
    source = File.expand_path('../../templates', __FILE__)
    initializer "logging.rb", File.read(File.join(source, "logging.rb"))
    gem 'slf4r', :require => 'slf4r/logging'
    gem "logging"
  end
end
