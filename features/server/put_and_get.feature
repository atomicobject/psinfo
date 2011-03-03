Feature: Put and get commands
  As a server
  I want to store a list of pid and names given to me by a client
  Each pid and name pair is marked with a unique id
  If a client asks for a the id, then it should get the pairs back

    Scenario: Putting and getting one pair
      Given the server is online
      When I put the pid "68" with the name "ack" for id "187"
        And I get the pairs for id "187"
      Then the pid "68" with the name "ack" should be returned

    Scenario: Putting and getting multiple pairs
      Given the server is online
      When I put the pid "1" with the name "init" for id "abc"
        And I put the pid "99" with the name "ps" for id "abc"
        And I put the pid "187" with the name "ruby" for id "abc"

      When I get the pairs for id "abc"
      Then the pid "1" with the name "init" should be returned
        And the pid "99" with the name "ps" should be returned
        And the pid "187" with the name "ruby" should be returned

    Scenario: Putting and getting different ids
      Given the server is online
      When I put the pid "1" with the name "init" for id "123"
        And I put the pid "99" with the name "ps" for id "abc"

      When I get the pairs for id "123"
      Then the pid "1" with the name "init" should be returned

      When I get the pairs for id "abc"
      Then the pid "99" with the name "ps" should be returned

    Scenario: Getting an id that the server doesn't know
      Given the server is online
      When I put the pid "1" with the name "init" for id "abc"
        And I get the pairs for id "aardvark"
      Then the client should receive a negative response
