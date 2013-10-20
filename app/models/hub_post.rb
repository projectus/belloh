class HubPost < ActiveRecord::Base
	include Post::Filter
  belongs_to :virtual_hub	
	validates_presence_of :virtual_hub
end
