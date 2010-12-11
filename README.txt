= SLF4R

the main idea is from www.slf4j.org which is to provide an uniform interface for instantiating und using of a logger. but the actual logging is done by some third party logging framework.

the idea is to have a logger per class or object (see also http://slf4j.org/). in ruby you would have something like

   @logger = Slf4r::LoggerFacade.new(self.class)

or the convinience module inside any class which needs logging

   include Slf4r::Logger

if the underlying logging framework allows it (like logging or log4r) then you get a logger for each namespace of your class and create a hierachy of loggers. with this you can control the log level for each logger and/or namespace separately or any branch of the hierachy tree.

for example you have a framework A with namespace 'A' then you can set the log level for the logger with name 'A' to debug and get all the debug from the framework, etc.

in case you have a framework B which uses log4r internally you can use the 'log4r_adapter' to delegate the logger creation from log4r to slf4r. in this way you have only one place where logging gets configured and controlled.

== SYNOPSIS:

=== using with logging gem

require 'slf4r/logging_logger'

Logging.logger.root.appenders = Logging.appenders.file("developent.log"),
    :level => :debug,
    :layout => Logging.layouts.pattern(:pattern => '%d %l (%c) - %m\n')
)

=== using with ruby logger (from MRI)

require 'slf4r/ruby_logger'

Slf4r::LoggerFacade4RubyLogger.level = :warn # default :debug
Slf4r::LoggerFacade4RubyLogger.file = "development.log" # default STDOUT
Slf4r::LoggerFacade4RubyLogger.dateformat = "%Y%m%d %H:%M:%S - " # default "%Y-%m-%d %H:%M:%S "

=== using with rails/merb/datamapper logger

require 'slf4r/wrapped_logger'

Slf4r::LoggerFacade4WrappedLogger.logger = framwork_logger

=== using with slf4j with jruby

require 'slf4r/init_slf4j'

just get the needed jar files/ configuration files in the classpath
(see http://slf4j.org/) or if you use maven then have a look at the
pom.xml of this very project.

this require falls back on the standard ruby logger if there is no slf4j in the classpath.

=== usign a noop logger

require 'slf4r/noop_logger'

=== getting an instance of a logger

* logger = Slf4r::LoggerFacade.new("Fully::Qualified::Class::Name")
or
* logger = Slf4r::LoggerFacade.new("any name you wish")
or
* logger = Slf4r::LoggerFacade.new(Fully::Qualified::Class::Name)

there are following log-levels:
* logger.debug("asd") or logger.debug { "asd" } and logger.debug?
* logger.info("asd") or logger.info { "asd" } and logger.warn?
* logger.warn("asd") or logger.warn { "asd" } and logger.info?
* logger.error("asd") or logger.error { "asd" } and logger.error?
* logger.fatal("asd") or logger.fatal { "asd" } and logger.fatal?

the block variant will evaluate the block only if the log level indicates logging to avoid needless string operations.

* logger.name
will return the log category or name

== INSTALL:

=== general 

$ gem install slf4r

=== Rails3

=== use the Rails.logger as slf4r logger

add in your Gemfile

  gem 'slf4r'

=== rails generators

setup a log4j logging (fallback on rails logging without JRUBY)

$ rails3 generate slf4r:log4j

but to use this you need to add slf4j-log4j12-1.6.1.jar to you classpath or require the jar. see below how to do this with ruby-maven gem.

setup a logging from logging gem

$ rails3 generate slf4r:logging

all these setups use the same files as default rails and adjust the log level from the rails config. they establish the folowing categories:
* Rails
* <NAME>.Application # where the name is your application name
* ActionController
* ActiveRecord
* ActionView
* ActionMailer
* ActiveSupport::Cache::Store

== use ruby-maven to add jar files to your rails3 application (experimental)

install it with
$ jruby -S gem install ruby-maven --pre

then you can run the rails3 with log4j wioth
$ rmvn rails server
or the generator
$ rmv rails generate . .
or the rake
$ rmvn rake . . .
or console/dbconsole
$ rmvn rails console
$ rmvn rails dbconsole
or run the server in jetty
$ jetty-run

*NOTE* it is a prerelease so there are bugs and limitations

== TODO:

* the bridge from ruby to java, i.e. using rails logging for java libraries using slf4j, i.e. the java classes will log into the rails logging framework
* follow the naming of slf4j
* for the completeness: generators for jdk14, java-commons-logging, logback, log4r
* generators for slf4j should take advantage of ruby-maven and configure the jar in Gemfile as dependency

== LICENSE:

(The MIT License)

Copyright (c) 2010 kristian meier

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
