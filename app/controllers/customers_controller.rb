class CustomersController < ApplicationController
  
  def index
    @title = "Home"
    @customers = Customer.all
  end
  
  def new
    @title = "Kunden erfassen"
    @customer = Customer.new
    render 'forms'
  end
  
  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      redirect_to root_path #will probably be changed to show_path
    else
      @title = "Kunden erfassen"
      render 'forms'
    end
  end
  
  def edit
    @customer = Customer.find(params[:id])
    @title = "Kunden editieren"
    render 'forms'
  end
  
  def update
    @customer = Customer.find(params[:id])
     if @customer.update_attributes(params[:customer])
       redirect_to root_path, :flash => { :success => "Informationen angepasst." }
     else
       @title = "Kunden editieren"
       render 'edit'
     end
   end
  
  def show
    @title = "Kundenname" #provisorisch
  end

end
