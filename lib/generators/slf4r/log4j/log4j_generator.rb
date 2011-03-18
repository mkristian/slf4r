class Slf4r::Log4jGenerator < Rails::Generators::Base
  #source_root File.expand_path('../templates', __FILE__)

  def setup
    source = File.expand_path('../../templates', __FILE__)
    initializer "log4j.rb", File.read(File.join(source, "log4j.rb"))
    initializer "log4j.properties", File.read(File.join(source, "log4j.properties"))
    gem 'slf4r', :require => 'slf4r/java_logger'

    file_name = 'Mavenfile'
    jar_line = "org.slf4j.slf4j-log4j12"
    mavenfile = File.exists?(file_name) ? File.read(file_name) : ''
    unless mavenfile =~ /#{jar_line}/
      File.open(file_name, 'a') do |f|
        f.puts "jar '#{jar_line}', '1.6.1'"
      end
    end
  end
end
