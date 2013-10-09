module ApplicationHelper
	def hub_name
		@virtual_hub.nil? ? '' : ' @ [ ' + @virtual_hub.name + ' ]'
	end
end
