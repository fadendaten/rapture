Feature: New customer
  In order to manage customer relationships
  As a user
  I want to be able to create new customers
  
  Scenario: admin user follows link to create new customer
    Given I am logged in as a "admin"
    And I should see "neuen Kunden erfassen"
    When follow "neuen Kunden erfassen"
    Then I should see "Neuen Kunden erfassen"
    
  Scenario: admin user fills out form and submits it
    Given I am logged in as a "admin"
    And I follow "neuen Kunden erfassen"
    When I fill in "Firmenname:" with "Fadendaten"
    And I fill in "Telefon:" with "034 445 39 08"
    And I press "Speichern"
    Then I should see "Kunde wurde erfolgreich erfasst"
    And I should see "Fadendaten"
  
  
  
  
  
  

  
