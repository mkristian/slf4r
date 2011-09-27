require 'pathname'
require Pathname(__FILE__).dirname.expand_path + 'logger_helper'

basedir = Pathname(__FILE__).dirname.parent.expand_path
load basedir + 'lib' + 'slf4r' + 'logging_logger.rb'
require 'slf4r/logging_logger'

Logging.init :debug, :info, :warn, :error

appender = Logging::Appenders::File.new("test", :filename => basedir + 'tmp' + 'logging.txt' )
#appender.layout = Logging::Layouts::Pattern.new(:pattern => "%d [%-l] (%c) %m\n")
logger = Logging::Logger.new(:root)
logger.add_appenders(appender)
logger.level = :debug

behave_as_logger(Slf4r::Logger.new('logging'))
