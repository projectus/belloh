class WelcomeController < ApplicationController
  def index
	  @post = Post.new
    if session[:coords].nil?
      setup_posts_of_the_world
	  else
	    @posts = Post.near(session[:coords],1,:order => {:created_at=>:desc})
	    @location = session[:location]
		end
  end
end
