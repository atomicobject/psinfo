require "aruba/cucumber"

IP = "localhost"
PORT = "1234"

def poll(msg=nil, seconds=2.0, fail_on_timeout=true) 
  (seconds * 10).to_i.times do 
    return if yield
    sleep 0.1
  end
  msg ||= "polling failed after #{seconds} seconds" 
  flunk msg if fail_on_timeout
end

class ServerState
  class << self; attr_accessor :server; end
end

at_exit do
  ServerState.server.stop if ServerState.server
end

Given /^the server is online$/ do
  if ServerState.server.nil? or not ServerState.server.alive?
    ServerState.server = ChildProcess.build("ruby", "#{APP_ROOT}/cheater/server.rb", IP, PORT, "start")
    ServerState.server.start
  end
  ServerState.server.alive?.should be_true
end

When /^I run the server with parameters "([^"]*)"$/ do |params|
  When %+I run "ruby #{APP_ROOT}/cheater/server.rb #{params}"+
end

When /^I send "([^"]*)" to the server$/ do |signal|
  # Yes, I know I'm breaking encapsulation. I need that pid!
  Process.kill(signal, ServerState.server.pid)
end

Then /^the server should exit$/ do
  poll "server didn't exit in time" do
    ServerState.server.alive? == false
  end
end

When /^I ping the server$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the client should receive a positive response$/ do
  pending # express the regexp above with the code you wish you had
end
