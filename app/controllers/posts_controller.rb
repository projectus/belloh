class PostsController < ApplicationController

  def index	
    if params[:lat]=='nil' || params[:lat].nil?
      setup_posts_of_the_world
      session[:lat] = nil
      session[:lng] = nil
    else
		  coords = [params[:lat],params[:lng]]
      @posts = Post.near(coords,1,:order => {:created_at=>:desc})
      result = Geocoder::search(coords).first
      @location = result.nil? ? 'undefined' : result.address
      session[:lat] = params[:lat]
      session[:lng] = params[:lng]
    end

	  respond_to do |format|
		  format.html { redirect_to root_url }
      format.js
    end
	end

  def create
	  @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_url }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :receiver_desc, 
        :sender_desc, :latitude, :longitude, :mood)
    end
end
