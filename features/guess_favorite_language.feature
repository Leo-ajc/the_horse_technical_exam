Feature: Guess a Github user's favorite language
  In order to discover a Github user's favorite language
  A User
  Should enter an arbitary Github username

  Scenario: Guess a Github user's favorite language
    Given I am on the Github favorite language guess page
    When I enter an arbitary Github username
    Then I should see the username's favorite language
    
  Scenario: Shows error if Github username does not exist
    Given I am on the Github favorite language guess page
    When I enter an Github username that does not exist
    Then I should see an error notice the Github username does not exist 

  Scenario: Shows error if Github username is empty
    Given I am on the Github favorite language guess page
    When I do not enter any value into Github username field
    Then I should see an error notice requesting a Github username 

