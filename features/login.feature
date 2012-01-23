Feature: Login
  In order to keep our secrets from other fashion labels
  As a user
  I want to be able to login with a secure password.
  
  Scenario: normal user logs into rapture.
    Given I go to the signin page
    And I fill in "Benutzername:" with "dummy"
    And I fill in "Passwort:" with "test123"
    When I press "Einloggen"
    Then I should be on the index page
    And I should see some Customers
  
  
