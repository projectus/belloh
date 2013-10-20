class ApplicationController < ActionController::Base	
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def lat_lng_are_floats?(lat,lng)
      Float(lat) && Float(lng) rescue false
    end

    def params_or_session(key)
	    return params[key] unless params[key].nil?
	    session[key]
	  end

    def setup_location_posts # find nearby posts
	    setup_posts
	
			# location stuff
		  lat   = params_or_session(:lat)
	    lng   = params_or_session(:lng)
		  range = params_or_session(:range)
		  range = 'near' if Post::RANGES[range].nil?

      if lat_lng_are_floats?(lat,lng)
		    @posts = @posts.nearby([lat,lng], Post::RANGES[range])
	      result = Geocoder::search([lat,lng]).first
	      @location = result.nil? ? 'undefined' : result.address 
        {lat:lat,lng:lng,range:range}
      else
	      @location = I18n.t(:around_the_world)
        {lat:nil,lng:nil,range:range}
      end
	  end
		
    def setup_posts	# filters and paginates posts
	    if params[:page].nil?
		    filtr = params[:filter]
		    session[:filter] = filtr
		    session[:latest] = nil
		  else
			  filtr = session[:filter]
			end

      @posts = Post.page(params[:page]).before(session[:latest])
			
		  words = filtr.to_s.split('@')

	    if words.size > 1
	      @posts = @posts.descs_like(words[0],words[-1])
	    elsif !words.empty?
	      @posts = @posts.desc_like(words[0])
	    end
	  end
end
