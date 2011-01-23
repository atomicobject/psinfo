class Server
  class Stopit < RuntimeError
  end

  IP = "127.0.0.1"
  PORT = "1234"

  class << self
    def start(ip = IP, port = PORT)
      @thread = Thread.new do
        Server.new.start(ip, port)
      end
    end

    def stop
      @thread.raise(Stopit) if @thread
      @thread = nil
    end
  end

  def start(ip = IP, port = PORT)
    begin
      server = TCPServer.open(ip, port)
      loop do
        @socket = server.accept
        case @socket.gets.strip
        when "ping"
          @socket.puts "pong"
        end
        @socket.close
        @socket = nil
      end
    ensure
      @socket.close if @socket
    end
  end
end
