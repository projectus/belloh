class Location < ActiveRecord::Base
  has_many :posts, as: :postable
	
	reverse_geocoded_by :latitude, :longitude
	
	scope :nearby, lambda {|coords,radius|
		near(coords, radius, :order => {:created_at=>:desc})}
			
	RANGES = {'near'=>0.05,'mid'=>0.5,'far'=>5}
end
