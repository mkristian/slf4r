#-*- mode: ruby -*-

def exec(command)
  ruby = (defined? JRUBY_VERSION) ? "jruby" : "ruby"
  run "#{ruby} #{command}"
end

def run_rake(arg, output = nil, options = {})
  if output.is_a? Hash
    options = output
    output = nil
  end
  env  = options[:env] || 'development'
  rake_command = "#{ENV['GEM_HOME']}/bin/rake"
  rake_command = "-S rake" unless File.exists?(rake_command)
  exec "#{rake_command} #{arg} RAILS_ENV=#{env}#{output ? ' > ' + output : ''}" 
end

def run_generate(*args)
  command = "#{ENV['GEM_HOME']}/bin/rails"
  command = "-S rails" unless File.exists?(command)
  exec "#{command} generate #{args.join(' ')} >> error.txt" 
end

def run_mvn(goal, *args)
  run "mvn de.saumya.mojo:rails3-maven-plugin:0.23.0-SNAPSHOT:#{goal} #{args.join(' ')} -Dgem.home=#{ENV['GEM_HOME']} -Dgem.path=#{ENV['GEM_PATH']} >> error.txt"
end

def bundle_install
  if defined? JRUBY_VERSION
#    run "unset GEM_HOME; unset GEM_PATH;rmvn gem:initialize -Dgem.home=#{ENV['GEM_HOME']} -Dgem.path=#{ENV['GEM_PATH']}"
  end	
end
