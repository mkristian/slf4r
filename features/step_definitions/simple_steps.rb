require 'fileutils'
Given /^I create new rails application with template "(.*)"$/ do |template|
  name = template.sub(/.template$/, '')
  directory = File.join('target', name)
  rails_version = ENV['RAILS_VERSION'] || '3.0.1'

  ruby = defined?(JRUBY_VERSION) ? "jruby" : "ruby"
  rails_command = "#{ENV['GEM_HOME']}/bin/rails"
  rails_command = "-S rails" unless File.exists?(rails_command)
  command = "#{rails_command} _#{rails_version}_ new #{directory} -f -m templates/#{template}"
  FileUtils.rm_rf(directory)

  system "#{ruby} #{command}"
  
  @result = File.read("target/#{name}/log/development.log")
  puts @result
end

Then /^the output should contain \"(.*)\"$/ do |expected|
  (@result =~ /.*#{expected}.*/).should_not be_nil
end

