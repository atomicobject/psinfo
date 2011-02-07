Feature: Halting the server
  As a user operating the server
  I want to be able to halt the server with a signal

  Scenario: Sending SIGUSR1 to the server
    Given the server is online
    When I send "SIGUSR1" to the server
    Then the server should exit
