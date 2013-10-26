class PostsController < ApplicationController	
  def index
    setup_location_posts
	  respond_to do |format|
		  format.html { redirect_to root_url }
      format.js
    end
	end
  
  def sync
	  setup_location_posts(true)
	  respond_to do |format|
      format.js
    end
	end
	
  def create
    if user_signed_in?
      @post = current_user.posts.build(post_params)
	    unless is_me_the_only_reference?(@post.sender_desc)
        redirect_to posts_url, alert: 'you can only reference yourself (&me) as sender'
        return
      end
    else
	    @post = Post.new(post_params)
	    unless are_there_no_references?(@post.sender_desc)
        redirect_to posts_url, alert: 'sign in to reference as a sender'
        return
      end
    end
    respond_to do |format|
      if @post.save
	      setup_new_posts(Post)
	      format.html { redirect_to root_url }
        format.js { render 'sync' }
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
