require 'slf4r/logger_module'

if defined?(Rails)
  require 'slf4r/railtie'
end

# first import bridge from slf4j to slf4r when it is in classloader
is_slf4j_to_slf4r = false
if defined? JRUBY_VERSION
  require 'java'
  begin
    import 'de.mkristian.slf4j.impl.Slf4rLoggerFactory'
    is_slf4j_to_slf4r = true
  rescue NameError
    # ignore
  end
end

#second make sure there is a Slf4r::Logger
unless defined? Slf4r::Logger
  if is_slf4j_to_slf4r
    # we have slf4j-slf4r bridge but no ruby logging => use default
    puts "using ruby logger"
    require 'slf4r/ruby_logger'
  else
    # no slf4j-slf4r bridge in place
    if defined? JRUBY_VERSION
      require 'java'
      begin
        # make sure we have SLF4J in the classloader
        import 'org.slf4j.LoggerFactory'
        org.slf4j.LoggerFactory.getLogger("root")
        
        # now we can use java logging for the slf4r
        require 'slf4r/java_logger'
        puts "using slf4j logger"
      rescue NameError
        puts "no SLF4J found in classloader - using ruby logger"
        require 'slf4r/ruby_logger'
      end
    else
      # no java, no slf4j => default ruby logging
      puts "using ruby logger"
      require 'slf4r/ruby_logger'
    end
  end
end

# third setup the slf4j-slf4r bridge if used
if is_slf4j_to_slf4r
  f = de.mkristian.slf4j.impl.Slf4rLoggerFactory.new
  f.setSlf4rLoggerClass Slf4r::Logger
end
