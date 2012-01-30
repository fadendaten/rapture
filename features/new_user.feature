Feature: New user
  In order to ensure all customers are taken care of
  As a sudo user
  I want to be able to create new users
  
  Scenario: sudo user follows link to create a new user
    Given I am logged in as a "sudo"
    And I should see "Einstellungen"
    When I follow "Einstellungen"
    Then I should see "neuen Benutzer erfassen"
    
  Scenario: sudo creates new sudo user
    Given I am logged in as a "sudo"
    And I follow "Einstellungen"
    And I follow "neuen Benutzer erfassen"
    Then I should be on the new user page
    And I fill in "Benutzername:" with "Dani"
    And I fill in "Vorname:" with "Daniel"
    And I fill in "Nachname:" with "Radiel"
    And I fill in "E-Mail:" with "dani@dnai.com"
    And I check "sudo"
    And I fill in "Authentifizierung:" with "foobar"
    When I press "Speichern"
    Then I should see "Benutzer wurde erfolgreich erfasst."
    And I should see "Dani"
    And I should see "sudo"
    
  Scenario: sudo creates new base user
    Given I am logged in as a "sudo"
    And There is a "sudo" role
    And There is a "admin" role
    And There is a "base" role
    And I follow "Einstellungen"
    And I follow "neuen Benutzer erfassen"
    Then I should be on the new user page
    And I fill in "Benutzername:" with "Dani"
    And I fill in "Vorname:" with "Daniel"
    And I fill in "Nachname:" with "Radiel"
    And I fill in "E-Mail:" with "dani@dnai.com"
    And I check "base"
    And I fill in "Authentifizierung:" with "foobar"
    When I press "Speichern"
    Then I should see "Benutzer wurde erfolgreich erfasst."
    And I should see "Dani"
    And I should see "base"
    
  Scenario: sudo can not create new user without password confirmation
    Given I am logged in as a "sudo"
    And There is a "sudo" role
    And There is a "admin" role
    And There is a "base" role
    And I follow "Einstellungen"
    And I follow "neuen Benutzer erfassen"
    Then I should be on the new user page
    And I fill in "Benutzername:" with "Dani"
    And I fill in "Vorname:" with "Daniel"
    And I fill in "Nachname:" with "Radiel"
    And I fill in "E-Mail:" with "dani@dnai.com"
    And I check "base"
    And I fill in "Authentifizierung:" with "FALSCHES PASSWORT"
    When I press "Speichern"
    Then I should see "Die Authentifizierung ist fehlgeschlagen."
    And I should be on the users page
    And I fill in "Authentifizierung" with "foobar"
    And I press "Speichern"
    And I should see "Benutzer wurde erfolgreich erfasst."
    And I should see "Dani"
  
  
  
  
  
  
  
  
  
  
  
  
