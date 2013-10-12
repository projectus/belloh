class PostsController < ApplicationController

  def index
    coords=setup_posts(params[:lat],params[:lng])
    session[:lat] = coords[:lat]
    session[:lng] = coords[:lng]

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
        format.html { render partial: 'form', locals: {post:@post} }
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
