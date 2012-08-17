

Given /^A base user exists$/ do
  User.delete_all
  @user = FactoryGirl.create(:user)
  @user.user_roles << FactoryGirl.create(:base)
end
  
