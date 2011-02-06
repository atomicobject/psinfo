require "aruba/cucumber"

at_exit do
  Server.stop
end

Given /^the server is online$/ do
  Server.start(Server::IP, Server::PORT)
end

Given /^the server is offline$/ do
  Server.stop
end

When /^I run the client with parameters "([^"]*)"$/ do |params|
  When %+I run "ruby #{APP_ROOT}/cheater/client.rb #{params}"+
end

When /^I ping the server$/ do
  When %+I run the client with parameters "#{Server::IP} #{Server::PORT} ping"+
end

When /^I put the pid "([^"]*)" with name "([^"]*)" for id "([^"]*)"$/ do |pid, name, id|
  When %+I run the client with parameters "#{Server::IP} #{Server::PORT} put #{id} #{pid} #{name}"+
end

When /^I get the pairs for id "([^"]*)"$/ do |id|
  When %+I run the client with parameters "#{Server::IP} #{Server::PORT} get #{id}"+
end
