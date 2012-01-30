Feature: New user
  In order to ensure all customers are taken care of
  As a sudo user
  I want to be able to create new users
  
  Scenario: sudo user follows link to create a new user
    Given I am logged in as a "sudo"
    And I should see "Einstellungen"
    When I follow "Einstellungen"
    Then I should see "neuen Benutzer erfassen"
    
  Scenario: sudo fills out new user form and submits it
    Given I am logged in as a "sudo"
    And I follow "Einstellungen"
    And I follow "neuen Benutzer erfassen"
    Then I should be on the new user page
    And I fill in "Benutzername:" with "Dani"
    And I fill in "Vorname:" with "Daniel"
    And I fill in "Nachname:" with "Radiel"
    And I fill in "E-Mail:" with "dani@dnai.com"
    And show me the page
    And I check "_user_role_ids_1"
    And I fill in "Authentifizierung:" with "foobar"
    When I press "Speichern"
    Then I should see "Benutzer wurde erfolgreich erfasst."
    # And I should be on the user show page
  
  
  
  
  
  
