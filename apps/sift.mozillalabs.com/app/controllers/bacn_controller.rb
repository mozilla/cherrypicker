class BacnController < ApplicationController
  
  before_filter :authenticate
  
  # TODO: We should only be skipping if we do API auth (HTTP BASIC) in application_controller#authenticate
  skip_before_filter :verify_authenticity_token, :only => [:create]

  respond_to  :html, :json, :text
  
  
  # curl \
  # --user foo:bar \
  # -d @fixtures/twitter_follow.email \
  # -H "Content-Type:text/plain" \
  # -H "Accept:application/json" \
  # "http://localhost:3000/bacn"
  
  def create
    @bacn = Bacn.parse(request.body.read)
    respond_to do |format|
      format.html
      format.json { render :text => @bacn.to_json }
    end
  end
  
  def index
    
  end
  
  def show
  end
end
