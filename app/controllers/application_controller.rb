class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "YOU ARE NO LONGER WELCOME. GO AWAY!"
  end
  
  
end
