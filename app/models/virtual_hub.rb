class VirtualHub < ActiveRecord::Base
	has_many :posts, class_name: 'HubPost'
	
	validates_uniqueness_of :name
	validates_length_of :name, :minimum => 1, :maximum => 20
	
	before_save do self.name.downcase! end
end
