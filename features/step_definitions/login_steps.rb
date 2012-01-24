

Given /^A base user exists$/ do
  User.delete_all
  @user = Factory.create(:user)
  @user.user_roles << Factory(:base)
end
  
