Feature: Customer new status
  In order to estimate risks and keep check of company growth
  As a admin
  I want to see wether a customer is new, and decide how long customers are regarded as new customers.
  
  Scenario: admin user creates new customer, evaluates customers 'new' status
    Given I am logged in as a "admin"
    And A customer with company name "Dani" exists
    When I follow "Dani"
    Then I should see "new.gif"
  
  
  
