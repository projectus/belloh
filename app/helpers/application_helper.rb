module ApplicationHelper
	def hub_name
		@vhub.nil? ? '' : ' @ [ ' + @vhub.name + ' ]'
	end
	
	def hub_post?
		params[:controller] == 'virtual_hubs' || params[:controller] == 'hub_posts'
	end
end
