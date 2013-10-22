class HubPostsController < ApplicationController
	def index
		setup_posts(HubPost)

	  respond_to do |format|
		  format.html { redirect_to root_url }
      format.js
    end
	end
	
  def create	
    if user_signed_in?
      @post = current_user.hub_posts.build(post_params)
	    parse_references!(@post.sender_desc)
	    parse_references!(@post.receiver_desc)
	    parse_references!(@post.content)
    else
	    @post = HubPost.new(post_params)
    end
    respond_to do |format|
      if @post.save
	      format.html { redirect_to root_url }
        format.js { redirect_to hub_posts_url }
      else
        format.html { render partial: 'posts/form', locals: {post: @post} }
      end
    end
  end
	
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:hub_post).permit(:content, :receiver_desc, :sender_desc, :mood, :virtual_hub_id)
    end
end
