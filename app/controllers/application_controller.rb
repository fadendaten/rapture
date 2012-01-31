class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :store_location
  
  rescue_from CanCan::AccessDenied do |exception|
    security_breach_message = "You tried to bypass our security measures. " +
                              "You are no longer welcome in Rapture. " +
                              "Leave and take your loved ones with you."
    redirect_to root_path, :alert => security_breach_message
  end

  def store_location
      session[:user_return_to] = request.url unless params[:controller] == "devise/sessions"
  end

  def after_sign_in_path_for(resource)
      root_path # default: stored_location_for(resource) || root_path
  end
  
end
