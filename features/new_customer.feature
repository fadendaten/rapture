Feature: New customer
  In order to manage customer relationships
  As a user
  I want to be able to create new customers
  
  Scenario: admin user follows link to create new customer
    Given I am logged in as a "admin"
    And I should see "neuen Kunden erfassen" button
    When I press "neuen Kunden erfassen"
    Then I should see "Neuen Kunden erfassen"
    
  Scenario: admin user fills out form and submits it
    Given I am logged in as a "admin"
    And I press "neuen Kunden erfassen"
    When I fill in "Firmenname:" with "Fadendaten"
    And I fill in "Telefon:" with "034 445 39 08"
    And I press "Speichern"
    Then I should see "Kunde wurde erfolgreich erfasst"
    And I should see "Fadendaten"
    
  Scenario: admin user fills out form with complete address information
    Given I am logged in as a "admin"
    And I press "neuen Kunden erfassen"
    When I fill in "Firmenname:" with "Victoria's Secret"
    And I fill in "Telefon:" with "1234567890"
    And I fill in "Zeile 1:" with "Secretstreet 1"
    And I fill in "Postleitzahl:" with "1234"
    And I fill in "Stadt:" with "Columbus"
    And I press "Speichern"
    Then I should see "Kunde wurde erfolgreich erfasst"
    And I should see "Victoria's Secret"
    
  Scenario: admin user fills out form with incomplete address information
    Given I am logged in as a "admin"
    And I press "neuen Kunden erfassen"
    When I fill in "Firmenname:" with "Victoria's Secret"
    And I fill in "Telefon:" with "1234567890"
    And I fill in "Stadt:" with "Columbus"
    And I press "Speichern"
    Then I should see "muss ausgefüllt werden"
     
  Scenario: base user tries to invoke new action for customer
    Given I am logged in as a "base"
    And I should not see "neuen Kunden erfassen"
    When I go to the new customer page
    Then I should be on the home page
    And I should see "You tried to bypass our security measures."
  
  
  
  
  
  
  
  
  

  
