module ApplicationHelper
	def hub_name
		@vhub.nil? ? '' : ' @ [ ' + @vhub.name + ' ]'
	end
end
