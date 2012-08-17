
Given /^A customer with company name "([^"]*)" exists$/ do |arg1|
  FactoryGirl.create(:customer, :company => arg1)
end

Given /^I am logged in as a "([^"]*)"$/ do |arg1|
  @user = FactoryGirl.create(:user)
  @user.user_roles << FactoryGirl.create(arg1.to_sym)
  
  step %{I go to the home page}
  step %{I fill in "Benutzername:" with "#{@user.username}"}
  step %{I fill in "Passwort:" with "#{@user.password}"}
  step %{I press "Einloggen"}
end


Given /^There is a "([^"]*)" role$/ do |arg1|
  UserRole.create(:name => arg1)
  # @user = FactoryGirl.create(:user)
  #   @user.user_roles << FactoryGirl.create(:sudo)
  #   @user.user_roles << FactoryGirl.create(:admin)
  #   @user.user.roles << FactoryGirl.create(:base)
end