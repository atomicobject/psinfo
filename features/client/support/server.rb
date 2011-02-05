class Server
  class Stopit < RuntimeError; end
  IP = "127.0.0.1"
  PORT = 1234

  class << self
    def start(ip = IP, port = PORT)
      @thread = Thread.new do
        Server.new.start(ip, port, @responses)
      end
    end

    def stop
      @thread.raise(Stopit) if @thread
      @thread = nil
    end
  end

  def start(ip = IP, port = PORT, responses = {})
    data = {}
    begin
      server = TCPServer.open(ip, port)
      while (@socket = server.accept) do
        command = @socket.gets.strip.split(" ")
        case command.shift
        when "ping"
          @socket.puts "pong"
        when "put"
          id, pid, name = command.shift, command.shift, command.shift
          data[id] ||= []
          data[id] << [pid, name]
          @socket.puts "ACK"
        else
          @socket.puts "NACK"
        end
        @socket.close
      end
    ensure
      @socket.close if @socket
    end
  end
end
