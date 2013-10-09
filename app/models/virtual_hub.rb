class VirtualHub < ActiveRecord::Base
	has_many :hub_posts
	
	validates_uniqueness_of :name
end
