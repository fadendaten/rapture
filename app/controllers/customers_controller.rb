class CustomersController < ApplicationController
  
  before_filter :empty_customer, :only => [:new]
  before_filter :authenticate
  
  def index
    @title = "Home"
    @customers = Customer.alphabetical_group(params[:letter])
  end
  
  def new
    @title = "Kunden erfassen"
    render 'forms'
  end
  
  def create
    @customer = Customer.new(params[:customer])
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
    puts "blabnjafsdAERGSRHErszherzhEZRHJETZHTZ"
    @title = "Home"
    @customers = Customer.search(params[:search])
    render 'index'
  end


  protected
  
    def empty_customer
      @customer = Customer.new
    end
    
    def authenticate
      deny_access unless signed_in?
    end

end
