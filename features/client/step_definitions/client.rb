require "aruba/cucumber"

at_exit do
  Server.stop
end

After do
  Server.clear
end

Given /^the server is online$/ do
  Server.start(Server::IP, Server::PORT)
end

Given /^the server is offline$/ do
  Server.stop
end

When /^I run the client with parameters "([^"]*)"$/ do |params|
  if ENV["cheat"] or ENV["CHEAT"]
    When %+I run "ruby #{APP_ROOT}/cheater/client.rb #{params}"+
  else
    client_dir = "build/artifacts/release"
    client = "#{APP_ROOT}/#{client_dir}/client.exe"
    raise "There's no client in [#{client_dir}] ... try run [rake release] first." unless File.exist?(client)
    When %+I run "#{client} #{params}"+
  end
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

Then /^the client should receive a positive response$/ do
  Then %+the output should contain "ACK"+
end

Then /^the client should receive a negative response$/ do
  Then %+the output should contain "NACK"+
end
