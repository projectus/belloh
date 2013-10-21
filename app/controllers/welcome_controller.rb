class WelcomeController < ApplicationController
  def show
	  condition = (request.subdomain.present? && request.subdomain != "www")
		redirect_to root_url(subdomain: false) if condition
    
    coords=setup_location_posts
    @post = Post.new
		@post.latitude = coords[:lat].to_s
		@post.longitude = coords[:lng].to_s
		@range = coords[:range]
  end
end
