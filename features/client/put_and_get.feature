Feature: Put and get commands
  As a client
  I want to put a list of pid and names into the server
  Each pid and name pair is marked with a unique id
  Later, I want to get all of the pid and name pairs for the unique id

    Scenario: Putting and getting one pair
      Given the server is online
      When I send the following pairs to the server for id "10:23":
        | name | pid |
        | grep | 123 |
      Then the client should receive a positive response
        And the exit status should be 0

      When I get the pairs for id "10:23"
        Then the output should contain "123 grep"
        And the exit status should be 0

    Scenario: Putting and getting multiple pairs
      Given the server is online
      And I send the following pairs to the server for id "10:00AM":
        | name | pid |
        | init | 1   |
        | ps   | 99  |
        | ruby | 187 |
      When I get the pairs for id "10:00AM"
      Then the output should contain the following pairs:
        | name | pid | 
        | init | 1   | 
        | ps   | 99  | 
        | ruby | 187 | 

    Scenario: Putting and getting different ids
      Given the server is online
      And I send the following pairs to the server for id "11:00AM":
        | name | pid  | 
        | init | 1    | 
      And I send the following pairs to the server for id "11:30AM":
        | name | pid |  
        | perl | 99  |  
      When I get the pairs for id "11:30AM"
        Then the output should contain "99 perl"
        And the output should not contain "1 init"

    Scenario: Getting an id that the server doesn't know
      Given the server is online
      And I send the following pairs to the server for id "1:30PM":
        | name | pid |
        | init |  1  |
      When I get the pairs for id "3:30PM"
        And the exit status should be 1
