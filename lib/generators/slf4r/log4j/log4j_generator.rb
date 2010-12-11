class Slf4r::Log4jGenerator < Rails::Generators::Base
  #source_root File.expand_path('../templates', __FILE__)

  def setup
    source = File.expand_path('../../templates', __FILE__)
    initializer "log4j.rb", File.read(File.join(source, "log4j.rb"))
    initializer "log4j.properties", File.read(File.join(source, "log4j.properties"))
  end
end
