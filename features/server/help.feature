Feature: Help documentation
  As a user of the server application
  I want to see help on how to run it

  Scenario: Running the server with no parameters
    Given pending
    When I run the server with parameters ""
    Then the output should contain "server"
      And the output should contain "usage"

  Scenario: Running the server with --help
    Given pending
    When I run the server with parameters "--help"
    Then the output should contain "server"
      And the output should contain "start"
