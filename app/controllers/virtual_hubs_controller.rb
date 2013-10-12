class VirtualHubsController < ApplicationController
  def show
	  @vhub = VirtualHub.where(name: request.subdomain).first
	  if @vhub.nil?
	    @virtual_hub = VirtualHub.new
	    @virtual_hub.name = request.subdomain
	  else
	    @hub_post = HubPost.new
	    @hub_post.virtual_hub = @vhub
    end

    render :layout => 'hubs'
  end

  def create
    @virtual_hub = VirtualHub.new(vhub_params)
    respond_to do |format|
      if @virtual_hub.save
	      format.html { redirect_to root_path }
      else
        format.html { render action: 'show' }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def vhub_params
    params.require(:virtual_hub).permit(:name)
  end
end
