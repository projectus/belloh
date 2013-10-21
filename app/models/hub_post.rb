class HubPost < ActiveRecord::Base
	include Post::Filter
  belongs_to :virtual_hub
  belongs_to :sender, class_name: 'User'

  validates_presence_of :virtual_hub
end
