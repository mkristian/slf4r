require 'pathname'
require Pathname(__FILE__).dirname.expand_path + 'spec_helper'
def Slf4r.flush(klass)
  remove_const(klass.to_sym) if const_defined? klass.to_sym
end 

def behave_as_logger(logger)
  filename = logger.name
  describe logger.name do
    
    it 'should have a name' do
      logger.name.should == filename
      logger.name.should_not be_nil
    end
    
    it 'should log into a file - no method args' do
      len1 = File2String.new("tmp/#{filename}.txt").length
      logger.debug()
      len2 = File2String.new("tmp/#{filename}.txt").length
      len2.should > len1
      logger.info()
      len1 = File2String.new("tmp/#{filename}.txt").length
      len1.should > len2
      logger.warn()
      len2 = File2String.new("tmp/#{filename}.txt").length
      len2.should > len1
      logger.error()
      len1 = File2String.new("tmp/#{filename}.txt").length
      len1.should > len2
    end
    
    it 'should log into a file - via block' do
      len1 = File2String.new("tmp/#{filename}.txt").length
      logger.debug{}
      len2 = File2String.new("tmp/#{filename}.txt").length
      len2.should > len1
      logger.info{}
      len1 = File2String.new("tmp/#{filename}.txt").length
      len1.should > len2
      logger.warn{}
      len2 = File2String.new("tmp/#{filename}.txt").length
      len2.should > len1
      logger.error{}
      len1 = File2String.new("tmp/#{filename}.txt").length
      len1.should > len2
    end
    
    it 'should log into a file - exception' do
      exception = StandardError.new
      len1 = File2String.new("tmp/#{filename}.txt").length
      logger.debug{[nil,exception]}
      len2 = File2String.new("tmp/#{filename}.txt").length
      len2.should > len1
      logger.info{[nil,exception]}
      len1 = File2String.new("tmp/#{filename}.txt").length
      len1.should > len2
      logger.warn{[nil,exception]}
      len2 = File2String.new("tmp/#{filename}.txt").length
      len2.should > len1
      logger.error{[nil,exception]}
      len1 = File2String.new("tmp/#{filename}.txt").length
      len1.should > len2
    end
    
  end
end
