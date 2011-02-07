require "aruba/cucumber"

When /^I run the server with parameters "([^"]*)"$/ do |params|
  When %+I run "ruby #{APP_ROOT}/cheater/server.rb #{params}"+
end
