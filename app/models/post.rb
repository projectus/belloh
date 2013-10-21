module Filter
	extend ActiveSupport::Concern
	MOODS = [ 'neutral', 'positive', 'negative', 'caution' ]

	def self.moods
	  MOODS.map(&:capitalize)
	end
	
  def self.filter_query(query,columns)
	  words=query.split(/\s+/)
	  return nil if words.empty?
	  ilikes=[]
	  Array.wrap(columns).each do |c|
		  ilikes << '('+words.map {|x| c+" ILIKE '%"+x+"%'"}.join(' AND ')+')'
		end
		ilikes.join(' OR ')
	end
	
  included do
		validates :mood, inclusion: MOODS
	  before_validation do self.mood.downcase! end
		
		default_scope { order('created_at DESC') }
    scope :sender_desc_like, lambda {|sender_desc|
	    where(Filter.filter_query(sender_desc,'sender_desc'))}
    scope :receiver_desc_like, lambda {|receiver_desc| 
	    where(Filter.filter_query(receiver_desc,'receiver_desc'))}
	  scope :desc_like, lambda {|desc|
		  where(Filter.filter_query(desc,['sender_desc','receiver_desc']))}
		scope :descs_like, lambda {|sender_desc,receiver_desc|
			sender_desc_like(sender_desc).receiver_desc_like(receiver_desc)}
		scope :before, lambda {|latest|
			where("created_at <= ?", latest||=Time.now)}
  end
end

class Post < ActiveRecord::Base
	include Filter
  belongs_to :sender, class_name: 'User'

  reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	    if geo.city.nil?
		    obj.city = geo.state unless geo.state.nil?
		  else
			  obj.city  = geo.city
        obj.city += ', '+geo.state unless geo.state.nil?
      end
	    obj.country = geo.country unless geo.country.nil?
	  end
	end
	after_validation :reverse_geocode
	
	scope :nearby, lambda {|coords,radius|
		near(coords, radius, :order => {:created_at=>:desc})}
			
	RANGES = {'near'=>0.05,'mid'=>0.5,'far'=>5}
end

