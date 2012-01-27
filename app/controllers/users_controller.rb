class UsersController < ApplicationController
  
  load_and_authorize_resource
  # skip_load_resource :only => [:create]
  
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
      if @user.save!
        redirect_to @user, :flash => { :success => "Benutzer wurde erfolgreich erfasst." }
      else
        @title = "Benutzer erfassen"
        puts "DSHNBUANHUDLSBHULDSBHLUSDFHBUZ"
        render 'user_form', :flash => { :success => "Etwas ist schief gelaufen. Bitte versuchen sie es nochmal."}
      end
  end

  def edit
    @title = "#{@user.username} editieren"
    render 'user_form'
  end

  def update
    if @user.update_without_password(params[:user])
      @user.update_roles(params[:user][:user_role_ids])
      redirect_to @user, :flash => { :success => "Informationen angepasst." }
    else
      @title = "#{@user} editieren"
      render 'user_form'
    end
  end

  def show
  end

end
