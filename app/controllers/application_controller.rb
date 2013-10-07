class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def setup_posts_of_the_world
	    @posts = Post.all
      @location = "Around the World"
	  end
end
