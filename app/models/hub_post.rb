class HubPost < ActiveRecord::Base
  belongs_to :virtual_hub

	validates_presence_of :virtual_hub
end
