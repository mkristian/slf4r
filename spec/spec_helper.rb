class File2String < String

  def initialize(file)
    content = ''
    f = File.open(file, "r")
    f.each_line { |line|
      content += line
    }
    f.close
    super(content)
  end

end

$LOAD_PATH << Pathname(__FILE__).dirname.parent.expand_path + 'lib'
require 'slf4r'

Dir.mkdir(Pathname(__FILE__).dirname.parent.expand_path + 'tmp') unless File.exists?('tmp')
