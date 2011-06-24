class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def authenticate
    if !session[:user_id]
      flash[:notice] = "Please sign in or create an account to continue."
      session[:login_redirect] = request.url
      redirect_to :controller => :session, :action => :new
      return false
    end
  end
end
