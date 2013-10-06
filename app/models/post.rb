class Post < ActiveRecord::Base
	default_scope { order('created_at DESC') }
  
	reverse_geocoded_by :latitude, :longitude, :address => :location
	after_validation :reverse_geocode
	
	MOODS = [ 'neutral', 'positive', 'negative', 'caution' ]
  
	belongs_to :sender, class_name: 'User'
	
	validates :mood, inclusion: MOODS
	validates_presence_of :latitude, :longitude
end
