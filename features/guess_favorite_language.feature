Feature: Guess a Github user's favorite language
  In order to discover a Github user's favorite language
  A User
  Should enter an arbitary Github username

  Scenario: Guess a Github user's favorite langauge
    Given I am on the Github favorite language guess page
    When I enter an arbitary Github username
    Then I should see the username's favorite language
    
