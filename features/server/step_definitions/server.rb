require "aruba/cucumber"

When /^I run the server with parameters "([^"]*)"$/ do |params|
  When %+I run "ruby #{APP_ROOT}/cheater/server.rb #{params}"+
end

Given /^the server is online$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I send "([^"]*)" to the server$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the server should exit$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I ping the server$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the client should receive a positive response$/ do
  pending # express the regexp above with the code you wish you had
end
