class Post < ActiveRecord::Base
	default_scope { order('created_at DESC') }
  
	reverse_geocoded_by :latitude, :longitude, :address => :location
	
	MOODS = [ 'neutral', 'positive', 'negative', 'caution' ]
  
	belongs_to :sender, class_name: 'User'
	
	validates :mood, inclusion: MOODS
	validates_presence_of :latitude, :longitude

  before_validation do self.mood.downcase! end

	after_validation :reverse_geocode
	
	def self.moods
	  MOODS.map(&:capitalize)
	end
end
