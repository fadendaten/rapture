
Given /^A customer with company name "([^"]*)" exists$/ do |arg1|
  Factory.create(:customer, :company => arg1)
end

Given /^I am logged in as a "([^"]*)"$/ do |arg1|
  @user = Factory(:user)
  @user.user_roles << Factory(arg1.to_sym)
  
  step %{I go to the home page}
  step %{I fill in "Benutzername:" with "#{@user.username}"}
  step %{I fill in "Passwort:" with "#{@user.password}"}
  step %{I press "Einloggen"}
end


Given /^There is a "([^"]*)" role$/ do |arg1|
  UserRole.create(:name => arg1)
  # @user = Factory(:user)
  #   @user.user_roles << Factory(:sudo)
  #   @user.user_roles << Factory(:admin)
  #   @user.user.roles << Factory(:base)
end