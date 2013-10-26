class HubPostsController < ApplicationController
	def index
		vhub = VirtualHub.find(session[:vhub_id])
		setup_posts(vhub.posts)
	  respond_to do |format|
		  format.html { redirect_to root_url }
      format.js
    end
	end

  def sync
	  vhub = VirtualHub.find(session[:vhub_id])
	  setup_new_posts(vhub.posts)
	  respond_to do |format|
      format.js { render 'posts/sync' }
    end
	end
		
  def create	
    if user_signed_in?
      @post = current_user.hub_posts.build(post_params)
	    unless is_me_the_only_reference?(@post.sender_desc)
        redirect_to hub_posts_url, alert: 'you can only reference yourself (&me) as sender'
        return
      end
    else
	    @post = HubPost.new(post_params)
	    unless are_there_no_references?(@post.sender_desc)
        redirect_to hub_posts_url, alert: 'sign in to reference as a sender'
        return
      end
    end
    respond_to do |format|
      if @post.save
	      vhub = @post.virtual_hub
	      setup_new_posts(vhub.posts)
	      format.html { redirect_to root_url }
        format.js { render 'posts/sync' }
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
