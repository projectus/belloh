class PostsController < ApplicationController

  def index
	  @posts = Post.all
  end

  def show
	  @post = Post.find(params[:id])
  end

  def new
	  @post = Post.new
  end

  def create
	  @post = Post.new(post_params)
    p post_params
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :receiver_desc, 
        :sender_desc, :latitude, :longitude)
    end
end
