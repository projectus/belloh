class HubPostsController < ApplicationController
  def create
	  @hub_post = HubPost.new(post_params)
    respond_to do |format|
      if @hub_post.save
	      format.html { redirect_to root_url }
        format.js
      else
	      format.html
        format.js
      end
    end
  end
	
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:hub_post).permit(:content, :receiver_desc, :sender_desc, :mood, :virtual_hub_id)
    end
end
