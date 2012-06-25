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
    client = "#{APP_ROOT}/#{client_dir}/client"
    raise "There's no client in [#{client_dir}] ... try run [rake release] first." unless File.exist?(client)
    When %+I run "#{client} #{params}"+
  end
end

When /^I ping the server$/ do
  When %+I run the client with parameters "#{Server::IP} #{Server::PORT} ping"+
end

Given /^I send the following pairs to the server for id "([^"]*)":$/ do |id, table|
  table.hashes.each do |hash|
    When %+I run the client with parameters "#{Server::IP} #{Server::PORT} put #{id} #{hash[:pid]} #{hash[:name]}"+
  end
end

When /^I get the pairs for id "([^"]*)"$/ do |id|
  When %+I run the client with parameters "#{Server::IP} #{Server::PORT} get #{id}"+
end

Then /^the output should contain the following pairs:$/ do |table|
  table.hashes.each do |hash|
    Then %+the output should contain "#{hash[:pid]} #{hash[:name]}"+
  end
end

Then /^the client should receive a positive response$/ do
  Then %+the output should contain "ACK"+
end

Then /^the client should receive a negative response$/ do
  Then %+the output should contain "NACK"+
end
