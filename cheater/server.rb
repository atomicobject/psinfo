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

def close_sockets
  @server.close if @server
  @socket.close if @socket
end

keep_going = true
trap "USR1" do
  keep_going = false
  close_sockets
end

def ack; @socket.puts "ACK"; end
def nack; @socket.puts "NACK"; end

while keep_going do
  data = {}
  @server = TCPServer.open(ip, port)
  @socket = @server.accept
  command = @socket.gets.strip.split(/\s+/)
  case command.shift
  when "ping"; ack
  when "put"
    id, pid, name = command.shift, command.shift, command.shift
    data[id] << [pid, name]
    ack
  else; nack
  end
end

close_sockets
