require "aruba/cucumber"

When /^I run the client with parameters "([^"]*)"$/ do |params|
  When %+I run "ruby #{APP_ROOT}/cheater/client.rb #{params}"+
end
