Feature: Ping command
  As a server
  I want to respond to clients wondering if I'm online

  Scenario: Responding to a ping
    Given the server is online
    When I ping the server
    Then the client should receive a positive response
