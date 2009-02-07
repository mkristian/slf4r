require 'rubygems'
require 'pathname'

dir = Pathname(__FILE__).dirname.expand_path + 'slf4r'

require dir + 'version'
require dir + 'logger'

