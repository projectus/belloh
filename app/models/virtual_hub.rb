class VirtualHub < ActiveRecord::Base
	has_many :posts, class_name: 'HubPost'
	
	validates_uniqueness_of :name
	before_save do self.name.downcase! end
end
