class CustomersController < ApplicationController
  
  before_filter :empty_customer, :only => [:new]
  
  def index
    @title = "Home"
    @customers = Customer.all
  end
  
  def new
    @title = "Kunden erfassen"
    render 'forms'
  end
  
  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      redirect_to root_path, :flash => { :success => "Kunde wurde erfolgreich hinzugefuegt." } #will probably be changed to show_path
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
    @customer = Customer.find(params[:id])
    @title = "Kundenname" #provisorisch
  end


  protected
  
  def empty_customer
    @customer = Customer.new
  end
  
end
