require 'pathname'
require Pathname(__FILE__).dirname.expand_path + 'logger_helper'

Object.class_eval do
  remove_const :Slf4r
end

basedir = Pathname(__FILE__).dirname.parent.expand_path
load basedir + 'lib' + 'slf4r' + 'abstract_logger_facade.rb'
load basedir + 'lib' + 'slf4r' + 'log4r_logger.rb'
require 'slf4r/log4r_logger'

Log4r::Logger.root.level = Log4r::DEBUG

out = Log4r::FileOutputter.new('logfile', 
                               :filename => (basedir + 'tmp' + 'log4r.txt').to_s,
                               :trunc=>false,
                               :level => Log4r::DEBUG)
logger =  Log4r::Logger.new("log4r")
logger.add('logfile')

behave_as_logger(Slf4r::LoggerFacade.new('log4r'))
