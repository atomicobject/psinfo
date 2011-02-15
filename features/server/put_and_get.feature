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
