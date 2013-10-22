module ApplicationHelper
  def bootstrap_alert_type(key)
    return 'alert alert-danger fade in' if key.to_s == 'alert'
	  return 'alert alert-success fade in' if key.to_s == 'notice'
  end
	
	def hub_post?
		params[:controller] == 'virtual_hubs' || params[:controller] == 'hub_posts'
	end
end
