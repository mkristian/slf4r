require 'pathname'
require 'fileutils'
require 'logger'
require Pathname(__FILE__).dirname.expand_path + 'logger_helper'

basedir = Pathname(__FILE__).dirname.parent.expand_path
load basedir + 'lib' + 'slf4r' + 'wrapped_logger.rb'

logger = ::Logger.new(basedir + 'tmp' + 'wrapped.txt')
logger.level == ::Logger::DEBUG

Slf4r::WrappedLogger.logger = logger

behave_as_logger(Slf4r::Logger.new('wrapped'))
