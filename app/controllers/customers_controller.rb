class CustomersController < ApplicationController
  
  load_and_authorize_resource
  skip_authorize_resource :only => [:index, :search]
  before_filter :authenticate
  before_filter :empty_customer, :only => [:new]
  
  def index
    @title = "Home"
    @customers = Customer.alphabetical_group(params[:letter])
  end
  
  def new
    @title = "Kunden erfassen"
    render 'forms'
  end
  
  def create
    if @customer.save
      redirect_to @customer, :flash => { :success => "Kunde wurde erfolgreich erfasst." }
    else
      @title = "Kunden erfassen"
      render 'forms'
    end
  end
  
  def edit
    @title = "#{@customer} editieren"
    render 'forms'
  end
  
  def update
     if  @customer.update_attributes(params[:customer])
       redirect_to @customer, :flash => { :success => "Informationen angepasst." }
     else
       @title = "#{@customer} editieren"
       render 'forms'
     end
   end
  
  def show
    @title = @customer.company
  end
  
  def search
    @title = "Home"
    @customers = Customer.search(params[:search])
    render 'index'
  end


  protected
  
    def authenticate
      deny_access unless signed_in?
    end
  
    def empty_customer
      @customer = Customer.new
    end

end
