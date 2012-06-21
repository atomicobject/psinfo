Feature: Put and get commands
  As a server
  I want to store a list of pid and names given to me by a client
  Each pid and name pair is marked with a unique id
  If a client asks for a the id, then it should get the pairs back

    Scenario: Putting and getting one pair
      Given the server is online
      When I put the following pairs into the server for id "10:37":
        | name | pid |
        | ack  | 68  |
      And I get the pairs for id "10:37"
      Then the pid "68" with the name "ack" should be returned

    Scenario: Putting and getting multiple pairs
      Given the server is online
      When I put the following pairs into the server for id "10:37":
        | name | pid | 
        | init | 1   | 
        | ps   | 99  | 
        | ruby | 187 | 
      When I get the pairs for id "10:37"
      Then the following pairs should be returned:
        | name | pid | 
        | init | 1   | 
        | ps   | 99  | 
        | ruby | 187 | 

    Scenario: Putting and getting different ids
      Given the server is online
      When I put the following pairs into the server for id "11:42":
        | name | pid | 
        | init | 1   |
      And I put the following pairs into the server for id "16:12":
        | name | pid | 
        | ps   | 99  |

      When I get the pairs for id "11:42"
      Then the pid "1" with the name "init" should be returned

      When I get the pairs for id "16:12"
      Then the pid "99" with the name "ps" should be returned

    Scenario: Getting an id that the server doesn't know
      Given the server is online
      When I put the following pairs into the server for id "00:17":
        | name | pid | 
        | init | 1   |
      And I get the pairs for id "19:35"
      Then the client should receive no records
