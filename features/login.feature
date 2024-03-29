Feature: Login
  In order to keep our secrets from other fashion labels
  As a user
  I want to be able to login with a secure password.
  
  Scenario: normal user logs into rapture.
    Given A base user exists
    And I go to the signin page
    And I fill in "Benutzername:" with "dummy"
    And I fill in "Passwort:" with "foobar"
    When I press "Einloggen"
    Then I should be on the home page
    And I should see "Kunden"
  
  
