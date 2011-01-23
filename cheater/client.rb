#!/usr/bin/env ruby
require "socket"

if ARGV.size < 3 or ARGV.first == "--help"
  puts "usage: client.rb <server ip> <server port> <command> <command options...>"
  puts "\t valid commands:"
  puts "\t ping - ping the server and print the response"
  exit 0
end

ip, port, command = ARGV.shift, ARGV.shift, ARGV.shift
case command.strip
when "ping"
  socket = TCPSocket.new(ip, port)
  socket.puts "ping"
  puts socket.gets
end
