module ApplicationHelper
	def hub_name
		@vhub.nil? ? '' : ' @ [ ' + @vhub.name + ' ]'
	end
	
	def latitude
		session[:lat].to_s
	end
	
	def longitude
		session[:lng].to_s
	end
end
