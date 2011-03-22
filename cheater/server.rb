#!/usr/bin/env ruby
require "childprocess"
require "socket"
require "pp"

def help
  puts "usage: server.rb start <ip> <port>"
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
if ChildProcess.unix?
  trap "USR1" do
    keep_going = false
    close_sockets
  end
end

def ack; @socket.puts "ACK"; end
def nack; @socket.puts "NACK"; end

@server = TCPServer.open(ip, port)
data = Hash.new {|h, k| h[k] = []}
while keep_going do
  begin
    @socket = @server.accept
  rescue Errno::EBADF => ok
    # thrown when @server.accept interrupted by SIGUSR1
    # swallow and allow program to shutdown
    @server = nil
    next
  end
  command = @socket.gets.strip.split(/\s+/)
  case command.shift
  when "ping"; ack
  when "put"
    id, pid, name = command.shift, command.shift, command.shift
    data[id] << [pid, name]
    ack
  when "get"
    stuff = data[command.shift]
    if stuff.empty? then nack
    else
      @socket.puts stuff.size
      stuff.each { |(pid, name)| @socket.puts "#{pid} #{name}" }
    end
  else; nack
  end
  @socket.close
  @socket = nil
end

close_sockets
