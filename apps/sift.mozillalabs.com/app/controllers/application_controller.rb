class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def browser_id_audience
    request.headers['HTTP_HOST']
  end
  
  def authenticate
    
    if request.authorization.blank?
      if !session[:user]
        flash[:notice] = "Please sign in or create an account to continue."
        session[:login_redirect] = request.url
        redirect_to :controller => :session, :action => :new
        return false
      end
    else
      authenticate_with_http_basic do |username, password|
        username == "foo" && password == "bar"
      end
    end
  end
end
