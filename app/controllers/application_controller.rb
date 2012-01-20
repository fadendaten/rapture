class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "You tried to bypass our security measures. You are no longer welcome in Rapture. Leave and take your loved ones with you."
  end
  
  
end
