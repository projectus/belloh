class WelcomeController < ApplicationController
  def show
		redirect_to root_url(subdomain: false) if request.subdomain.present?
    coords=setup_posts(session[:lat],session[:lng])
    I18n.locale = :en
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
