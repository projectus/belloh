class WelcomeController < ApplicationController
  def show
		redirect_to root_url(subdomain: false) if request.subdomain.present?
	  I18n.locale = :en
	  @post = Post.new
	  lat = session[:lat]
	  lng = session[:lng]
    if lat.nil? || lng.nil?
      setup_posts_of_the_world
		  lat = 'nil'
		  lng = 'nil'
	  else
	    @posts = Post.near([lat,lng],1,:order => {:created_at=>:desc})
	    @location = session[:location]
		end
		@post.latitude = lat
		@post.longitude = lng
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

  def cn
    render :layout => 'chinese'
  end

  def test
    render :layout => 'test'
  end
end
