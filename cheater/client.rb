#!/usr/bin/env ruby
require "socket"

def help
  puts "usage: client.rb <server ip> <server port> <command> <command options...>"
  puts "\tvalid commands:"
  puts "\tping - ping the server and print the response"
  puts "\tput <id> <pid> <name> - add a unique name for an id and pid"
  puts "\tget <id> - get all of the pid and names for an id"
  puts "\tping - ping the server and print the response"
  exit 0
end

help if ARGV.size < 3 or ARGV.first == "--help"

ip, port, command = ARGV.shift, ARGV.shift, ARGV.shift
socket = TCPSocket.new(ip, port)
case command.strip
when "ping"
  socket.puts "ping"
  puts socket.gets
when "put"
  id, pid, name = ARGV.shift, ARGV.shift, ARGV.shift
  socket.puts "put #{id} #{pid} #{name}"
  puts socket.gets
when "get"
  id = ARGV.shift
  socket.puts "get #{id}"
  response = socket.gets.chomp.to_i
  if response.zero? then exit 1
  else; response.times { puts socket.gets }; end
else
  help
end
