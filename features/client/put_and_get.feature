Feature: Put and get commands
  As a client
  I want to put a list of pid and names into the server
  Each pid and name pair is marked with a unique id
  Later, I want to get all of the pid and name pairs for the unique id

    Scenario: Putting and getting one pair
      Given the server is online
      When I put the pid "123" with name "grep" for id "10:23:00"
      Then the client should receive a positive response
        And the exit status should be 0
      
      When I get the pairs for id "10:23:00"
        Then the output should contain "123 grep"
        And the exit status should be 0

    Scenario: Putting and getting multiple pairs
      Given the server is online
      When I put the pid "1" with name "init" for id "abc"
        And I put the pid "99" with name "ps" for id "abc"
        And I put the pid "187" with name "ruby" for id "abc"

      When I get the pairs for id "abc"
      Then the output should contain "1 init"
        And the output should contain "99 ps"
        And the output should contain "187 ruby"

    Scenario: Putting and getting different ids
      Given the server is online
      When I put the pid "1" with name "init" for id "123"
        And I put the pid "99" with name "ps" for id "abc"

      When I get the pairs for id "123"
      Then the output should contain "1 init"

      When I get the pairs for id "abc"
      Then the output should contain "99 ps"

    Scenario: Getting an id that the server doesn't know
      Given the server is online
      When I put the pid "1" with name "init" for id "abc"
        And I get the pairs for id "123"
      Then the exit status should be 1
