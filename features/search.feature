Feature: Search
  In order to operate this application efficiently
  As a user
  I want fast and reliable search possibilities
  
  Scenario: normal user searches for customer Chuck Testa
    Given A customer with company name "Chuck Testa" exists
    And A customer with company name "Anne Banne" exists
    And I am logged in as a "admin"
    And I am on the home page
    And I should see "Alle Kunden"
    And I should not see "Chuck Testa"
    When I fill in "search_field" with "Chuck"
    And press "Kunden suchen"
    Then I should see "Chuck Testa"
  
  
  

  
