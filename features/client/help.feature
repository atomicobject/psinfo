Feature: Help documentation
  As a user of the client application
  I want to see help on how to run it

  Scenario: Running client with no parameters
      When I run the client with parameters ""
      Then the output should contain "client"
        And the output should contain "usage"

  Scenario: Running client with --help
      When I run the client with parameters "--help"
      Then the output should contain "client"
        And the output should contain "usage"
        And the output should contain "ping"
        And the output should contain "put"
        And the output should contain "get"
