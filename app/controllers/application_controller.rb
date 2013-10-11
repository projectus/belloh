class ApplicationController < ActionController::Base	
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def setup_posts_around_world
	    @posts = Post.all
      @location = I18n.t(:around_the_world)
    end

    def setup_posts_around_location(coords,radius)
      @posts = Post.near(coords, radius, :order => {:created_at=>:desc})
      result = Geocoder::search(coords).first
      @location = result.nil? ? 'undefined' : result.address
    end

    def lat_lng_are_floats?(lat,lng)
      Float(lat) && Float(lng) rescue false
    end

    def setup_posts(lat,lng)
      if lat_lng_are_floats?(lat,lng)
        setup_posts_around_location([lat,lng],1)
        {lat:lat,lng:lng}
      else
        setup_posts_around_world
        {lat:nil,lng:nil}
      end
    end
end
