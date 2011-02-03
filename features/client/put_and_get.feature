Feature: Put and get commands
  As a client
  I want to put a list of pid and names into the server
  Each pid and name pair is marked with a unique id
  Later, I want to get all of the pid and name pairs for the unique id

    Scenario: Putting and getting one pair
      Given the server is online
      When I put the pid "123" with name "grep" for id "10:23:00"
        And I get the pairs for id "10:23:00"
      Then the output should contain "123"
        And the output should contain "grep"
