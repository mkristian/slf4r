if defined? JRUBY_VERSION
  # load log4j configuration
  props = java.util.Properties.new
  props.load(java.io.FileInputStream.new(File.join(File.dirname(__FILE__), 'log4j.properties')))
  
  # use rails default log file location
  props.setProperty("log4j.appender.logfile.File", File.join(Rails.root, "log", "#{Rails.env}.log"))
  
  # adjust the log level
  root = props.getProperty("log4j.rootCategory")
  props.setProperty("log4j.rootCategory", root.sub(/^[a-zA-Z]+/, Rails.application.config.log_level.to_s))

  # configure log4j
  org.apache.log4j.PropertyConfigurator.configure(props)
else
  Rails.logger.debug("skip log4j config since no jruby is used")
end
