

Given /^A normal user exists$/ do
  User.delete_all
  @user = Factory.create(:user)
end
  
