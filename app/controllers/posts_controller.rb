class PostsController < ApplicationController

  def index
    coords=setup_location_posts
    session[:lat] = coords[:lat]
    session[:lng] = coords[:lng]
    session[:range] = coords[:range]

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
        format.js { redirect_to posts_url }
      else
        format.html { render partial: 'posts/form', locals: {post: @post} }
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
