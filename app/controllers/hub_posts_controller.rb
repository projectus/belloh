class HubPostsController < ApplicationController
  def create
	  @hub_post = HubPost.new(hub_post_params)
    respond_to do |format|
      if @hub_post.save
	      format.html
        format.js
      else
	      format.html
        format.js
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def hub_post_params
      params.require(:hub_post).permit(:content, :receiver_desc, :sender_desc, :mood, :virtual_hub_id)
    end
end
