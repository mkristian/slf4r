class Slf4r::Log4jGenerator < Rails::Generators::Base
  #source_root File.expand_path('../templates', __FILE__)

  def setup
    source = File.expand_path('../../templates', __FILE__)
    initializer "log4j.rb", File.read(File.join(source, "log4j.rb"))
    initializer "log4j.properties", File.read(File.join(source, "log4j.properties"))

    gemfile = File.read('Gemfile')
    jar_line = "org.slf4j.slf4j-log4j12"
    unless gemfile =~ /#{jar_line}/
      File.open('Gemfile', 'a') do |f|
        f.puts
        f.puts "if defined? MAVEN"
        f.puts "  jar '#{jar_line}', '1.6.1'"
        f.puts "end"
      end
    end
  end
end
