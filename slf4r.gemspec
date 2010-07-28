# create by maven - leave it as is
Gem::Specification.new do |s|
  s.name = 'slf4r'
  s.version = '0.3.3'

  s.summary = 'Slf4r'
  s.description = 'Slf4r provides a uniform interface for instantiating und using of a logger'
  s.homepage = 'http://github.com/mkristian/slf4r'

  s.authors = ['Kristian Meier']
  s.email = ['m.kristian@web.de']

  s.files = Dir['MIT-LICENSE']
  s.licenses << 'MIT-LICENSE'
  s.files += Dir['History.txt']
  s.files += Dir['README.txt']
  s.extra_rdoc_files = ['History.txt','README.txt']
  s.files += Dir['Rakefile']
  s.rdoc_options = ['--main','README.txt']
  s.files += Dir['lib/**/*']
  s.files += Dir['spec/**/*']
  s.test_files += Dir['spec/**/*_spec.rb']
  s.add_development_dependency 'rspec', '1.3.0'
  s.add_development_dependency 'logging', '1.4.1'
  s.add_development_dependency 'log4r', '1.1.7'
end