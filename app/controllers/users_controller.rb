class UsersController < ApplicationController
  
  load_and_authorize_resource
  
  def index
    @title = "Alle Benutzer"
    @users = User.all
  end
  
  def new
    @title = "Benutzer erfassen"
    render 'user_form'
  end
  
  def create
    if @user.save
      redirect_to @user, :flash => { :success => "Benutzer wurde erfolgreich erfasst." }
    else
      @title = "Benutzer erfassen"
      render 'user_form'
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def show
    
  end
  

end
