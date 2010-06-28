require 'slf4r/logger'
begin
  require 'slf4r/java_logger'
rescue LoadError
  require 'slf4r/ruby_logger'
end
