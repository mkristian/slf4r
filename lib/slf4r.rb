require 'slf4r/logger'
begin
  # make sure we have java
  require 'java'
  begin
    # make sure we have SLF4J in the classloader
    import 'org.slf4j.LoggerFactory'
  rescue NameError
    puts "no SLF4J found in classloader - using ruby logger"
    require 'slf4r/ruby_logger'
  end
  require 'slf4r/java_logger'
  puts "using slf4j logger"
rescue LoadError
  puts "using ruby logger"
  require 'slf4r/ruby_logger'
end
