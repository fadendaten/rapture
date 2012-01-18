require 'spec_helper'

describe CustomersController do
  render_views
  
  before(:each) do
    @customer = Factory(:customer)
  end

  describe "GET 'new'" do
    
    describe "for non-signed in users" do
      
      it "should deny access" do
        get :new
        response.should redirect_to(signin_path)
      end
      
    end
    
    describe "for signed in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
      
      it "should return http success" do
        get :new
        response.should be_success
      end

      it "should have the right title" do
        get :new
        response.should have_selector( 'title', :content => "Kunden erfassen")
      end
      
    end
    
  end
  
  describe "GET 'edit'" do
    
    describe "for non-signed in users" do
      
      it "should deny access" do
        get :edit, :id => @customer 
        response.should redirect_to(signin_path)
      end
      
    end
    
    describe "for signed in users" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
      end
      
      it "should return http success" do
        get :edit, :id => @customer
        response.should be_success
      end

      it "should have the right title" do
        get :edit, :id => @customer
        response.should have_selector('title', :content => "#{@customer} editieren | Rapture" )
      end
      
    end
    
  end

end
