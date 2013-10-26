class VirtualHubsController < ApplicationController
	before_action :authenticate_user!, except: [:show]
  before_action :set_vhub, except: [:show,:create]
	
  def show
	  @vhub = VirtualHub.where(name: request.subdomain).first
	  if @vhub.nil?
	    @virtual_hub = VirtualHub.new
	    @virtual_hub.name = request.subdomain
	  else
	    @hub_post = HubPost.new
	    @hub_post.virtual_hub = @vhub
	    setup_posts(@vhub.posts)
	    @background = @vhub.background
	    @avatar = @vhub.avatar
	    session[:vhub_id] = @vhub.id
    end
  end

  def create
    @virtual_hub = current_user.virtual_hubs.build(virtual_hub_params)
    respond_to do |format|
      if @virtual_hub.save
	      format.html { redirect_to root_path }
      else
        format.html { render action: 'show' }
      end
    end
  end

  def edit
	end
	
	def update
	  respond_to do |format|
      if @vhub.update(vhub_params)
	      format.html { redirect_to root_path }
      else
        format.html { render action: 'edit' }
      end
    end
	end
	
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def virtual_hub_params
    params.require(:virtual_hub).permit(:name)
  end

  def vhub_params
    params.require(:virtual_hub).permit(:description, :background, :avatar)
  end

  def set_vhub
	  @vhub = VirtualHub.where(name: request.subdomain).first
	  redirect_to root_path if @vhub.nil?
	end
end
