Feature: Search
  In order to operate this application efficiently
  As a user
  I want fast and reliable search possibilities
  
  Scenario: normal user searches for customer Chuck Testa
    Given A customer with name "Chuck Testa" exists
    And I am logged in
    And I am on the home page
    When I fill_in "search" with "Chuck"
    and press "Kunde suchen"
    Then I should see "Chuck Testa"
  
  
  

  
