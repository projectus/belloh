class ApplicationController < ActionController::Base	
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def setup_posts_around_world
	    filtr = params[:filter].to_s
		  names = filtr.split('@')
	    if names.size > 1
	      @posts = Post.sender_desc_like(names[0]).receiver_desc_like(names[-1])
	    elsif !names.empty?
	      @posts = Post.desc_like(names[0])
	    else
	      @posts = Post.all
	    end
      @location = I18n.t(:around_the_world)
    end

    def setup_posts_around_location(coords,filter_words,radius)
	    if filter_words.size > 1
	      @posts = Post.near(coords, radius, :units=>:km, :order => {:created_at=>:desc}).sender_desc_like(filter_words[0]).receiver_desc_like(filter_words[-1])
	    elsif !filter_words.empty?
	      @posts = Post.near(coords, radius, :units=>:km, :order => {:created_at=>:desc}).desc_like(filter_words[0])
	    else
	      @posts = Post.near(coords, radius, :units=>:km, :order => {:created_at=>:desc})
	    end
      result = Geocoder::search(coords).first
      @location = result.nil? ? 'undefined' : result.address
    end

    def lat_lng_are_floats?(lat,lng)
      Float(lat) && Float(lng) rescue false
    end

    def params_or_session(key)
	    return params[key] unless params[key].nil?
	    session[key]
	  end
	
    def setup_posts
	    lat=params_or_session(:lat)
	    lng=params_or_session(:lng)
		  words = params[:filter].to_s.split('@')
		  range = params_or_session(:range).to_s
		  range = 'near' if Post::RANGES[range].nil?
      if lat_lng_are_floats?(lat,lng)
        setup_posts_around_location([lat,lng],words,Post::RANGES[range])
        {lat:lat,lng:lng,range:range}
      else
        setup_posts_around_world
        {lat:nil,lng:nil,range:nil}
      end
    end
end
