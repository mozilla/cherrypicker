class PermissionsController < ApplicationController
  
  before_filter :authenticate
  
  # GET /permissions
  # GET /permissions.json
  def index
    @permissions = Permission.find_all_by_user_id(session[:user][:id])

    respond_to do |format|
      format.html do # index.html.erb
        
        # Create hash of only keys with all seen sources for this user
        @permissions_by_source = Hash[*Bacn.find(:all, 
          :order => :source, 
          :select => :source, 
          :group => :source,
          :conditions => {:user_id => session[:user][:id]}
        ).map{|b| [b.source, Permission.new(:source => b.source)]}.flatten]
        
        @permissions.each do |permission|
          @permissions_by_source[permission.source] = permission
        end
      end
      format.json  { render :json => @permissions }
    end
  end

  # POST /permissions.json
  def create
    @permission = Permission.find_or_create_by_user_id_and_source(session[:user][:id], params[:source])
    @permission.value = params[:value]
    respond_to do |format|
      if @permission.update_attributes(params[:permission])
        format.json  { head :ok }
      else
        format.json  { render :json => @permission.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /permissions/1.json
  def destroy
    @permission = Permission.find_by_id_and_user_id(params[:id], session[:user][:id])
    @permission.destroy

    respond_to do |format|
      format.json  { head :ok }
    end
  end
end
