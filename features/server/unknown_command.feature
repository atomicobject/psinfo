Feature: Handling unknown commands
  As a server
  I want to respond negatively to clients that send unrecognized commands

  Scenario: Responding to an unknown command
    Given the server is online
    When I send a bad command
    Then the client should receive a negative response
