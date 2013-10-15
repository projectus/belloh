class ApplicationController < ActionController::Base	
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def setup_posts_around_world
	    filtr = params[:filter].to_s
	    names = filtr.split(' @ ')
	    if names.size > 1
	      @posts = Post.where("lower(sender_desc) LIKE ? AND lower(receiver_desc) LIKE ?","%#{names[0].downcase}%","%#{names[-1].downcase}%")
      elsif !names.empty?
	      @posts = Post.where("lower(sender_desc) LIKE ? OR lower(receiver_desc) LIKE ?","%#{names[0].downcase}%","%#{names[0].downcase}%")
      else
	      @posts = Post.all
	    end
      @location = I18n.t(:around_the_world)
    end

    def setup_posts_around_location(coords,radius)
      @posts = Post.near(coords, radius, :order => {:created_at=>:desc}).where("sender_desc LIKE ?", "%#{params[:filter].to_s}%")
      result = Geocoder::search(coords).first
      @location = result.nil? ? 'undefined' : result.address
    end

    def lat_lng_are_floats?(lat,lng)
      Float(lat) && Float(lng) rescue false
    end

    def param_or_session(key)
	    return params[key] unless params[key].nil?
	    session[key]
	  end
	
    def setup_posts
	    lat=param_or_session(:lat)
	    lng=param_or_session(:lng)
      if lat_lng_are_floats?(lat,lng)
        setup_posts_around_location([lat,lng],1)
        {lat:lat,lng:lng}
      else
        setup_posts_around_world
        {lat:nil,lng:nil}
      end
    end
end
