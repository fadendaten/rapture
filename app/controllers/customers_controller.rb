class CustomersController < ApplicationController
  
  def index
    @title = "Home"
    @customers = Customer.all
  end
  
  def new
    @title = "Kunden erfassen"
    @customer = Customer.new
  end
  
  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      redirect_to root_path
    else
      @title = "Kunden erfassen"
      render 'new'
    end
  end
  
  def show
    @title = "Kundenname" #provisorisch
  end

end
