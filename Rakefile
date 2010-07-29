# -*- ruby -*-

require 'rubygems'

require 'spec'
require 'spec/rake/spectask'

BUILD_DIR = 'target'

desc 'clean up'
task :clean do
  FileUtils.rm_rf(BUILD_DIR)
  FileUtils.rm_rf('tmp')
end

desc 'package as a gem.'
task :package do
  require 'fileutils'
  gemspec = Dir['*.gemspec'].first
  Kernel.system("#{RUBY} -S gem build #{gemspec}")
  FileUtils.mkdir_p(BUILD_DIR)
  gem = Dir['*.gem'].first
  FileUtils.mv(gem, File.join(BUILD_DIR,"#{gem}"))
  puts File.join(BUILD_DIR,"#{gem}")
end

desc 'Install the package as a gem.'
task :install => [:package] do
  gem = Dir[File.join(BUILD_DIR, '*.gem')].first
  extra = ENV['GEM_HOME'].nil? && ENV['GEM_PATH'].nil? ? "--user-install" : ""
  Kernel.system("#{RUBY} -S gem install --local #{gem} --no-ri --no-rdoc #{extra}")
end

desc 'Run specifications'
Spec::Rake::SpecTask.new(:spec) do |t|
  if File.exists?('spec/spec.opts')
    t.spec_opts << '--options' << 'spec/spec.opts'
  end
  t.spec_files = Dir.glob('./spec/**/*_spec.rb')
end

# vim: syntax=Ruby
