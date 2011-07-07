class BacnController < ApplicationController
  
  before_filter :authenticate
  
  # TODO: We should only be skipping if we do API auth (HTTP BASIC) in application_controller#authenticate
  skip_before_filter :verify_authenticity_token, :only => [:create]

  respond_to  :html, :json, :text
  
  
  # curl \
  # --user foo:bar \
  # -d @fixtures/1.eml \
  # -H "Content-Type:text/plain" \
  # -H "Accept:application/json" \
  # "http://localhost:3000/bacn"
  
  def create
    @bacn = Bacn.parse(request.body.read)
    @bacon.save!
    respond_to do |format|
      format.json { render :text => @bacn.to_json }
    end
  end
  
  def index
    @bacns = Bacn.find_all_by_user_id(session[:user][:id])
    respond_to do |format|
      format.json do
        render :text => @bacns.to_json({
          :include => {
            :headers => {:only => [:name, :value]}, 
            :mime_parts => {:only => [:content_type, :body]},
          },
          :only => [
            :source,
            :id
          ]
        })
      end
    end
  end  
end
