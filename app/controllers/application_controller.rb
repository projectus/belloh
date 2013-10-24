class ApplicationController < ActionController::Base	
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
	  def is_me_the_only_reference?(text)
		  text.match(/&[^m][^e]/).nil?
		end
		
		def are_there_no_references?(text)
		  text.match(/&\w+/).nil?
		end
		
    def lat_lng_are_floats?(lat,lng)
      Float(lat) && Float(lng) rescue false
    end

    def params_or_session(key)
	    session[key] = params[key] unless params[key].nil?
	    session[key]
	  end

    def setup_location_posts # find nearby posts
	    setup_posts(Post)
	
			# location stuff
		  lat   = params_or_session(:lat)
	    lng   = params_or_session(:lng)
		  range = params_or_session(:range)
		  range = 'near' if Post::RANGES[range].nil?

      if lat_lng_are_floats?(lat,lng)
		    @posts = @posts.nearby([lat,lng], Post::RANGES[range])
	      result = Geocoder::search([lat,lng]).first
	      @location = result.nil? ? 'undefined' : result.address 
      else
	      @location = I18n.t(:around_the_world)
      end
	  end
		
    def setup_posts(post_type)	# filters and paginates posts
	    if params[:page].nil?
		    filtr = params[:filter]
		    session[:filter] = filtr
		    session[:latest] = nil
		  else
			  filtr = session[:filter]
			end

      @posts = post_type.filtr(filtr).page(params[:page]).before(session[:latest])
	  end
end
