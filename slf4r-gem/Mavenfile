#-*- mode: ruby -*-
plugin(:cucumber) do |cucumber|	
  cucumber.in_phase("integration-test").execute_goal(:test)
end
plugin(:gem) do |gem|
  gem.in_phase("pre-integration-test").execute_goal(:install)
end
	 
# vim: syntax=Ruby
