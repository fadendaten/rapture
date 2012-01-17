require 'spec_helper'

describe CustomersController do
  render_views
  
  before(:each) do
    @customer = Factory(:customer)
  end

  describe "GET 'new'" do
    
    it "should return http success" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector( 'title', :content => "Kunden erfassen")
    end
    
  end
  
  describe "GET 'edit'" do
    
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
