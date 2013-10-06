class PostsController < ApplicationController

  def index
  end

  def currloc
	  coords = [params[:lat],params[:lon]]
	  @posts = []#Post.near(coords,1,:order => {:created_at=>:desc})
	  @location = nil#Geocoder::search(coords).first.address
	  @post = Post.new
	  respond_to do |format|
      format.js
    end
	end

  def new
	  @post = Post.new
  end

  def create
	  @post = Post.new(post_params)
    p post_params
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
        :sender_desc, :latitude, :longitude)
    end
end
