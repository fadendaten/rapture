class CustomersController < ApplicationController
  
  # load_and_authorize_resource
  # skip_authorize_resource :only => [:index, :search]
  
  def index
    @title = "Alle Kunden"
    @customers = Customer.alphabetical_group(params[:letter])
  end
  
  def new
    @customer = Customer.new
    @title = "Kunden erfassen"
    render 'forms'
  end
  
  def create
    @customer = Customer.create!(params[:customer])
    if @customer.save
      redirect_to @customer, :flash => { :success => "Kunde wurde erfolgreich erfasst." }
    else
      @title = "Kunden erfassen"
      render 'forms'
    end
  end
  
  def edit
    @customer = Customer.find(params[:id])
    @title = "#{@customer} editieren"
    render 'forms'
  end
  
  def update
    @customer = Customer.find(params[:id])
     if  @customer.update_attributes(params[:customer])
       redirect_to @customer, :flash => { :success => "Informationen angepasst." }
     else
       @title = "#{@customer} editieren"
       render 'forms'
     end
   end
  
  def show
    @customer = Customer.find(params[:id])
    @title = @customer.company
  end
  
  def search
    @title = "Home"
    @customers = Customer.search(params[:search])
    render 'index'
  end
    
end
