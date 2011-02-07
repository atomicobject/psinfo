#!/usr/bin/env ruby

def help
  puts "usage: server.rb <ip> <port> <start>"
  puts "\tvalid commands:"
  puts "\tstart - run the server in a continuous loop"
  puts
  puts "halt the server with SIGUSR1"
  exit 0
end

help if ARGV.size < 3 or ARGV.first != "start"

keep_going = true
trap "USR1" do
  keep_going = false
end

while keep_going do
end
