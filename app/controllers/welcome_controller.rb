class WelcomeController < ApplicationController
  def show
	  condition = (request.subdomain.present? && request.subdomain != "www")
		redirect_to root_url(subdomain: false) if condition
    
    setup_location_posts
    @post = Post.new
		@post.latitude = session[:lat].to_s
		@post.longitude = session[:lng].to_s
		@range = session[:range].to_s
  end
end
