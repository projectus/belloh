class WelcomeController < ApplicationController
  def show
	  @post = Post.new
	  coords = session[:coords]
    if coords.nil?
      setup_posts_of_the_world
		  coords = ["nil","nil"]
	  else
	    @posts = Post.near(coords,1,:order => {:created_at=>:desc})
	    @location = session[:location]
		end
		@post.latitude = coords[0]
		@post.longitude = coords[1]
  end

  def about
  end

  def terms

  end

  def faq

  end

  def contact

  end

  def privacy

  end

  def here

  end

  def splash
    render :layout => 'splash'
  end

  def situations

  end

  def hubs
    render :layout => 'splash'
  end

  def uses

  end
end
