require "aruba/cucumber"

After do
  Server.stop
end

When /^the server is online$/ do
  Server.start
end

When /^the server is offline$/ do
  Server.stop
end

When /^I run the client with parameters "([^"]*)"$/ do |params|
  When %+I run "ruby #{APP_ROOT}/cheater/client.rb #{params}"+
end

When /^I contact the server with the command "([^"]*)"$/ do |command|
  When %+I run the client with parameters "#{Server::IP} #{Server::PORT} #{command}"+
end
