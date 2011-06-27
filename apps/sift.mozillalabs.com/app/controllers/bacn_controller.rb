class BacnController < ApplicationController
  
  before_filter :authenticate
  
  respond_to  :html, :json
  
end
