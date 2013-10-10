class PostsController < ApplicationController

  def index
	  coords = [params[:lat],params[:lon]]
	
    if coords[0]=='nil' || coords[0]==nil
      setup_posts_of_the_world
      session[:coords] = nil
    else
      @posts = Post.near(coords,1,:order => {:created_at=>:desc})
      result = Geocoder::search(coords).first
      @location = result.address unless result.nil?
      session[:coords] = coords
      session[:location] = @location
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
