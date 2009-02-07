# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/slf4r.rb'

Hoe.new('slf4r', Slf4r::VERSION) do |p|
  # p.rubyforge_name = 'slf4rx' # if different than lowercase project name
  p.developer('kristian', 'FIX@example.com')
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
end

desc 'Install the package as a gem.'
task :install => [:clean, :package] do
  gem = Dir['pkg/*.gem'].first
  sh "gem install --local #{gem} --no-ri --no-rdoc"
end

# vim: syntax=Ruby
