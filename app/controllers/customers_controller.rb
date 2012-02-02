class CustomersController < ApplicationController
  
  load_and_authorize_resource
  skip_authorize_resource :only => [:index, :search]
  before_filter :authenticate_user!
  
  def index
    @title = "Alle Kunden"
    if !params[:sort].nil?
      @customers = Customer.sorted(params[:sort], "company ASC").page(params[:page])
    elsif !params[:search].nil?
      @customers = Customer.search(params[:search]).page(params[:page])
    else
      @customers = Customer.alphabetical_group(params[:letter]).page(params[:page])
    end

    respond_to do |format|
      format.html
      format.csv do
        send_data(Customer.all.to_comma, :filename => "kunden.csv", :type => "text/csv")
      end
    end
  end
  
  def download
    send_data(Customer.all.to_comma, :filename => "kunden.csv", :type => "text/csv")
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
    @customer = Customer.find(params[:id])
    @title = @customer.company
  end
  
  def new_customer_duration
    duration = params[:duration]
    date_type = params[:date_type]
    new_duration = duration.to_i.send(date_type)
    Customer.new_customer_duration = new_duration
    redirect_to settings_path
  end
  
end
