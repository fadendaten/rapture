class UsersController < ApplicationController
  
  load_and_authorize_resource
  skip_load_resource :only => [:create]
  
  def index
    @title = "Einstellungen"
    @users = User.all
  end
  
  def new
    @title = "Benutzer erfassen"
    render 'user_form'
  end

  def create
    @user = User.build(params[:user])
      if current_user.valid_password?(params[:user][:password]) && @user.save
        redirect_to @user, :flash => { :success => "Benutzer wurde erfolgreich erfasst." }
      else
        @title = "Benutzer erfassen"
        flash.now[:error] = "Die Authentifizierung ist fehlgeschlagen."
        render 'user_form'
      end
  end

  def edit
    @title = "#{@user.username} editieren"
    render 'user_form'
  end

  def update
    if current_user.valid_password?(params[:user][:password]) && @user.update_without_password(params[:user])
      @user.set_roles(params[:user][:user_role_ids])
      redirect_to @user, :flash => { :success => "Informationen angepasst." }
    else
      @title = "#{@user.username} editieren"
      flash.now[:error] = "Die Authentifizierung ist fehlgeschlagen."
      render 'user_form'
    end
  end

  def show
    @title = @user.username
  end

end
