class UsersController < ApplicationController
  
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  
  def index
    @title = "Alle Benutzer"
    @users = User.all
  end
  
  def new
    @title = "Benutzer erfassen"
    render 'user_form'
  end
  
  def create
    @user = User.build(params[:user])
    if @user.save
      redirect_to @user, :flash => { :success => "Benutzer wurde erfolgreich erfasst." }
    else
      @title = "Benutzer erfassen"
      render 'user_form'
    end
  end
  
  def edit
    @title = "#{@user.username} editieren"
    render 'user_form'
  end
  
  def update
    if  @user.update_attributes(params[:user])
       redirect_to @user, :flash => { :success => "Informationen angepasst." }
     else
       @title = "#{@user} editieren"
       render 'user_form'
     end
  end
  
  def show
    
  end
  


end
