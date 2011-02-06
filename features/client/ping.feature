Feature: Ping command
  As a client
  I want to ping the server and see a response

    Scenario: Pinging the server
      Given the server is online
      When I ping the server
      Then the client should receive a positive response
