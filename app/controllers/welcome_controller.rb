class WelcomeController < ApplicationController
  def show
	  condition = (request.subdomain.present? && request.subdomain != "www")
		redirect_to root_url(subdomain: false) if condition
    coords=setup_posts
    I18n.locale = :fr
    @post = Post.new
		@post.latitude = coords[:lat].to_s
		@post.longitude = coords[:lng].to_s
  end

  def about
    render :layout => 'about'
  end

  def terms
    render :layout => 'about'

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

  def usage
    render :layout => 'about'
  end

  def cn
    render :layout => 'chinese'
  end

  def test
    render :layout => 'test'
  end

  def terminology
    render :layout => 'about'
  end

  def usage_cn
    render :layout => 'about'
  end
end
