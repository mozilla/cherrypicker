class SessionController < ApplicationController
  require 'browserid'
  
  def new
  end

  def destroy
  end

  def create
    if params[:session]
      @result = Mozilla::BrowserId.new.verify(params[:session][:assertion], browser_id_audience)

      if @result[:success]
        #TODO: deaul with "valid-until"
        user = User.find_or_create_by_email(@result[:email])
        session[:user] = user.session_hash
        
        if session[:login_redirect] && !(session[:login_redirect] =~ /\/session/)
          redirect_to session[:login_redirect]
        else
          redirect_to :dashboard
        end
      else
        render :action => 'error', :status => 403
        #TODO: deal with failure... ughgh, life's hard.
        puts "Life is hard."
      end
    else
      redirect_to :new
    end
  end
end
