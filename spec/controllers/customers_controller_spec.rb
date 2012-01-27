require 'spec_helper'

describe CustomersController do
  render_views
  
  before(:each) do
    @customer = Factory(:customer)
    @user = Factory(:user)
    @user.user_roles << Factory(:admin)
  end

  describe "GET 'new'" do
    
    describe "for non-signed-in users" do
      
      it "should deny access" do
        get :new
        response.should redirect_to(root_path)
      end
      
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        sign_in :user, @user
      end
      
      it "should return http success" do
        get :new
        response.should be_success
      end

      it "should have the right title" do
        get :new
        response.should have_selector('title', :content => "Kunden erfassen")
      end
      
      it "should have a company name field" do
        get :new
        response.should have_selector("input[name='customer[company]'][type='text']")
      end

      it "should have an email field" do
        get :new
        response.should have_selector("input[name='customer[email]'][type='text']")
      end

      it "should have a phone field" do
        get :new
        response.should have_selector("input[name='customer[phone]'][type='text']")
      end

      it "should have a mobile field" do
        get :new
        response.should have_selector("input[name='customer[mobile]'][type='text']")
      end
      
      it "should have a fax field" do
        get :new
        response.should have_selector("input[name='customer[fax]'][type='text']")
      end
      
    end
    
  end
  
  describe "GET 'index'" do
    
    describe "for non-signed-in users" do
      
      it "should deny access" do
        get :index
        response.should redirect_to(new_user_session_path)
      end
      
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        sign_in :user, @user
      end
      
      it "should return http success" do
        get :index
        response.should be_success
      end
      
      it "should have the right title" do
        get :index
        response.should have_selector('title', :content => "Alle Kunden")
      end
      
    end
    
  end
  
  describe "GET 'show'" do
    
    before(:each) do
      sign_in :user, @user
    end
    
    it "should be successful" do
      get :show, :id => @customer
      response.should be_success
    end
    
    it "should find the right user" do
      get :show, :id => @customer
      assigns(:customer).should == @customer
    end
    
    it "should have the right title" do
      get :show, :id => @customer
      response.should have_selector('title', :content => @customer.company)
    end
    
    it "should have the customers's company name" do
      get :show, :id => @customer
      response.should have_selector('h1', :content => @customer.company) 
    end
    
  end
  
  describe "GET 'edit'" do
    
    describe "for non-signed in users" do
      
      it "should deny access" do
        get :edit, :id => @customer 
        response.should redirect_to(root_path)
      end
      
    end
    
    describe "for signed-in users" do
      
      before(:each) do
        sign_in :user, @user
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
