require "aruba/cucumber"
require "socket"

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

Before do
  [ @pairs, @ping_response, @put_response, @bad_response ].each { |ivar| ivar = nil }
end

at_exit do
  ServerState.server.stop if ServerState.server
end

def verify_ack(str); str.strip.should == "ACK"; end
def verify_nack(str); str.strip.should == "NACK"; end
def verify_not_nack(str); str.should_not match("NACK"); end

Given /^the server is online$/ do
  if ServerState.server.nil? or not ServerState.server.alive?
    ServerState.server = ChildProcess.build("ruby", "#{APP_ROOT}/cheater/server.rb", "start", IP, PORT)
    ServerState.server.io.inherit!
    ServerState.server.start
    sleep 0.5
  end
  ServerState.server.alive?.should be_true
end

When /^I run the server with parameters "([^"]*)"$/ do |params|
  When %+I run "ruby #{APP_ROOT}/cheater/server.rb #{params}"+
end

When /^I send "([^"]*)" to the server$/ do |signal|
  Process.kill(signal, ServerState.server.pid)
end

Then /^the server should exit$/ do
  poll "server didn't exit in time" do
    ServerState.server.alive? == false
  end
end

def cmd(*args)
  returned = nil
  TCPSocket.open(IP, PORT) do |conn|
    conn.puts args.join(' ')
    returned = conn.gets
  end
  returned
end

When /^I put the pid "([^"]*)" with the name "([^"]*)" for id "([^"]*)"$/ do |pid, name, id|
  @put_response = cmd "put", pid, name, id
  verify_ack @put_response
end

When /^I get the pairs for id "([^"]*)"$/ do |id|
  @pairs = []
  TCPSocket.open(IP, PORT) do |conn|
    conn.puts "get #{id}"
    size = conn.gets.strip
    pp size
    verify_not_nack size
    size.to_i.times do
      pair = conn.gets.strip.split(/\s+/)
      @pairs << { :pid => pair.first, :name => pair.last }
    end
  end
  require "pp"
  pp @pairs
end

Then /^the pid "([^"]*)" with the name "([^"]*)" should be returned$/ do |pid, name|
  pair = @pairs.find { |p| p[:pid] == pid }
  pair.should_not be_nil
  pair[:name].should == name
end

When /^I ping the server$/ do
  @ping_response = cmd "ping"
end

Then /^the client should receive a positive response$/ do
  verify_ack @ping_response
end

When /^I send a bad command$/ do
  @bad_response = cmd "woops"
end

Then /^the client should receive a negative response$/ do
  verify_nack @bad_response
end
