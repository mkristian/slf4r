= slf4r

* FIX (url)

== DESCRIPTION:

the main ideas are from www.slf4j.org where the main idea is to provide a uniform interface for using instantiating und using a logger. but the actual logging is done by some third party logging framework.

one idea is to have a logger per class or object (see ). in ruby you would have something like

   @logger = Slf4r::LoggerFacade.new(self.class)

or the convinience module

   include Slf4r::Logger

if the underlying logging framework allows it (like logging or log4r) then you get a logger for each namespace of your class and create a hierachy of loggers. with this you can control the log level for each logger and/or namespace.

for example you have a framework A with namespace 'A' then you can set the log level for the logger with name 'A' to debug and get all the debug from the framework, etc.

in case you have a framework B which uses log4r internally you can use the 'log4r_adapter' to delegate the logger creation from log4r to slf4r. in this way you have only one place where logging gets configured and controlled.

== FEATURES/PROBLEMS:

* can replace other logging frameworks via adapters

* for the actual logging it depends on a third party logging framework

== SYNOPSIS:

=== using with logging gem

require 'slf4r/logging_logger'

Logging.init :debug, :info, :warn, :error

appender = Logging::Appender.stdout
appender.layout = Logging::Layouts::Pattern.new(:pattern => "%d [%-l] (%c) %m\n")
logger = Logging::Logger.new(:root)
logger.add_appenders(appender)
logger.level = :debug
logger.info "initialized logger . . ."

=== using with ruby logger

require 'slf4r/ruby_logger'

=== using the log4r adapter

require 'log4r_adapter'

=== using with rails/merb/datamapper logger

require 'slf4r/wrappered_logger'

LoggerFacade4WrappedLogger.logger(framwork_logger)

=== getting an instance of a logger

Slf4r::LoggerFacade.new("Full::Qualified::Class::Name")

== REQUIREMENTS:

* logging for slf4r/logging_logger

* log4r for slf4r/log4r_logger

== INSTALL:

* sudo gem install slf4r

* sudo gem install logging # optional

* sudo gem install log4r # optional

== LICENSE:

(The MIT License)

Copyright (c) 2009 kristian meier

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
