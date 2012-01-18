class SessionsController < ApplicationController
  
  def new
    @title = "Einloggen"
  end
  
  def create
    user = User.authenticate(params[:session][:username],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Falsche Benutzername/Passwort Kombination."
      @title = "Einloggen"
      render 'new'
    else
      sign_in user
      redirect_to customers_path
    end
  end
  
  def destroy
    sign_out
    redirect_to signin_path
  end
  
end
