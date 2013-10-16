module Filter
	extend ActiveSupport::Concern
	MOODS = [ 'neutral', 'positive', 'negative', 'caution' ]

	def self.moods
	  MOODS.map(&:capitalize)
	end
	
  def self.filter_query(query,columns)
	  words=query.split(/\s+/)
	  ilikes=[]
	  Array.wrap(columns).each do |c|
		  ilikes << '('+words.map {|x| c+" ILIKE '%"+x+"%'"}.join(' AND ')+')'
		end
		ilikes.join(' OR ')
	end
	
  included do
		belongs_to :sender, class_name: 'User'
		validates :mood, inclusion: MOODS
	  before_validation do self.mood.downcase! end
		
		default_scope { order('created_at DESC') }
    scope :sender_desc_like, lambda {|sender_desc|
	    where(Filter.filter_query(sender_desc,'sender_desc'))}
    scope :receiver_desc_like, lambda {|receiver_desc| 
	    where(Filter.filter_query(receiver_desc,'receiver_desc'))}
	  scope :desc_like, lambda {|desc|
		  where(Filter.filter_query(desc,['sender_desc','receiver_desc']))}
  end
end

class Post < ActiveRecord::Base
	include Filter
	reverse_geocoded_by :latitude, :longitude, :address => :location
	after_validation :reverse_geocode
	
	RANGES = {'near'=>0.05,'mid'=>0.5,'far'=>2}
end

