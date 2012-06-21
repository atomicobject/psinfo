class Server
  class Stopit < RuntimeError; end
  IP = "127.0.0.1"
  PORT = 1234

  class << self
    def start(ip = IP, port = PORT)
      return unless @thread.nil?
      @thread = Thread.new do
        Server.new.start(ip, port)
      end
    end

    def stop
      @thread.raise(Stopit) if @thread
      @thread = nil
    end

    def clear
      @@data = {}
    end
  end

  def nack
    @socket.puts "NACK"
  end

  def ack
    @socket.puts "ACK"
  end

  def start(ip = IP, port = PORT)
    @@data = {}
    begin
      server = TCPServer.open(ip, port)
      while (@socket = server.accept) do
        command = @socket.gets.strip.split(" ")
        case command.shift
        when "ping"; ack
        when "put"
          id, pid, name = command.shift, command.shift, command.shift
          @@data[id] ||= []
          @@data[id] << [pid, name]
          ack
        when "get"
          stuff = @@data[command.shift]
          if stuff.nil? then @socket.puts 0
          else
            @socket.puts stuff.size
            stuff.each { |(pid, name)| @socket.puts "#{pid} #{name}" }
          end
        else; nack
        end
        @socket.close
      end
    ensure
      @socket.close if @socket
    end
  end
end
