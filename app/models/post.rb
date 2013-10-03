class Post < ActiveRecord::Base
	reverse_geocoded_by :latitude, :longitude, :address => :location
	after_validation :reverse_geocode
	
	belongs_to :sender, class_name: 'User'
end
