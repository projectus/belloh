class VirtualHub < ActiveRecord::Base
	belongs_to :admin, class_name: 'User'
	has_many :posts, class_name: 'HubPost'
	
	has_attached_file :background, :size => { :in => 0..2.megabytes }#, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	has_attached_file :avatar, :styles => { :default => "300x300#" }, :size => { :in => 0..2.megabytes }
	
	validates_uniqueness_of :name
	validates_length_of :name, :minimum => 1, :maximum => 20
	validates_presence_of :admin
	
	before_save do self.name.downcase! end
end
