# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/slf4r/version.rb'

require 'spec'
require 'spec/rake/spectask'
require 'pathname'

Hoe.new('slf4r', Slf4r::VERSION) do |p|
  p.rubyforge_name = 'slf4r' # if different than lowercase project name
  p.summary = 'Slf4r provides a uniform interface for instantiating und using of a logger'
  p.url = 'http://slf4r.rubyforge.com/'
  p.developer('mkristian', 'm.kristian@web.de')
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.remote_rdoc_dir = '' # Release to root
end

desc 'Install the package as a gem.'
task :install => [:clean, :package] do
  Dir.new('tmp').each do |f|
    File.delete('tmp/' + f) if File.file?('tmp/' + f)
  end
  gem = Dir['pkg/*.gem'].first
  sh "gem install --local #{gem} --no-ri --no-rdoc"
end

desc 'Run specifications'
Spec::Rake::SpecTask.new(:spec) do |t|
  if File.exists?('spec/spec.opts')
    t.spec_opts << '--options' << 'spec/spec.opts'
  end
  t.spec_files = Pathname.glob('./spec/**/*_spec.rb')
end

# vim: syntax=Ruby
