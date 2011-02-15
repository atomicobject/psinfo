#!/usr/bin/env ruby
require "socket"

def help
  puts "usage: server.rb <ip> <port> <start>"
  puts "\tvalid commands:"
  puts "\tstart - run the server in a continuous loop"
  puts
  puts "halt the server with SIGUSR1"
  exit 0
end

help if ARGV.size < 3 or ARGV.shift != "start"
ip, port = ARGV.shift, ARGV.shift

keep_going = true
trap "USR1" do
  keep_going = false
  @server.close
  @socket.close
end

def ack; @socket.puts "ACK"; end
def nack; @socket.puts "NACK"; end

while keep_going do
  @server = TCPServer.open(ip, port)
  @socket = @server.accept
  command = @socket.gets.strip.split(/\s+/)
  case command.shift
  when "ping"; ack
  else; nack
  end
end

@server.close
@socket.close
