require 'pathname'
require 'fileutils'
require Pathname(__FILE__).dirname.expand_path + 'logger_helper'

Object.class_eval do
  remove_const :Slf4r
end

basedir = Pathname(__FILE__).dirname.parent.expand_path
load basedir + 'lib' + 'slf4r' + 'abstract_logger_facade.rb'
load basedir + 'lib' + 'slf4r' + 'ruby_logger.rb'
require 'slf4r/ruby_logger'

facade = Slf4r::LoggerFacade4RubyLogger
facade.file = basedir + 'tmp' + 'ruby_log.txt'
facade.level = ::Logger::DEBUG

behave_as_logger(Slf4r::LoggerFacade.new('ruby_log'))
