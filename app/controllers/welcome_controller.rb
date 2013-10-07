class WelcomeController < ApplicationController
  def index
	  @post = Post.new
	  @coords = session[:coords]
    if @coords.nil?
      setup_posts_of_the_world
		  @coords = ["nil","nil"]
	  else
	    @posts = Post.near(@coords,1,:order => {:created_at=>:desc})
	    @location = session[:location]
		end
  end
end
