class HubPost < ActiveRecord::Base
	default_scope { order('created_at DESC') }
	
  belongs_to :virtual_hub
	belongs_to :sender, class_name: 'User'

	MOODS = [ 'neutral', 'positive', 'negative', 'caution' ]
	
  before_validation do self.mood.downcase! end

	validates :mood, inclusion: MOODS
	validates_presence_of :virtual_hub
	
	def self.moods
	  MOODS.map(&:capitalize)
	end
end
