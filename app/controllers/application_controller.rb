class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  rescue_from CanCan::AccessDenied do |exception|
    security_breach_message = "You tried to bypass our security measures. " +
                              "You are no longer welcome in Rapture. " +
                              "Leave and take your loved ones with you."
    redirect_to root_path, :alert => security_breach_message
  end
  
end
