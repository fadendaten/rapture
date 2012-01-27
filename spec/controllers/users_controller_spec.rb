require 'spec_helper'

describe UsersController do
  render_views
  
  before(:each) do
    @user = Factory(:user)
    @user.user_roles << Factory(:sudo)
    sign_in :user, @user
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get :edit, :id => @user
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, :id => @user
      response.should be_success
    end
  end

end
