class PostsController < ApplicationController

  def currloc
	  coords = [params[:lat],params[:lon]]

    if coords.first == "nil"
      @posts = Post.all
      @location = "Around the World"
    else
      @posts = Post.near(coords,1,:order => {:created_at=>:desc})
      @location = Geocoder::search(coords).first.address

    end


	  respond_to do |format|
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
