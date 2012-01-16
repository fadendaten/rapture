class CustomersController < ApplicationController
  
  def index
    @title = "Home"
  end
  
  def new
    @title = "Kunden erfassen"
    @customer = Customer.new
    
  end
  
  def show
    @title = "Kundenname" #provisorisch
  end

end
