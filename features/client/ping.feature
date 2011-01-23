Feature: Ping command
  As a client
  I want to ping the server and see a response

    Scenario: Pinging the server
      When the server is online
        And I contact the server with the command "ping"
      Then the output should contain "pong"
