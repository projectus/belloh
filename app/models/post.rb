module Common
	extend ActiveSupport::Concern
	MOODS = [ 'neutral', 'positive', 'negative', 'caution' ]
	
  def self.filter_sql(query,columns)
	  words=query.split(/\s+/)
	  return nil if words.empty?
	  ilikes=[]
	  Array.wrap(columns).each do |c|
		  ilikes << '('+words.map {|x| c+" ILIKE '%"+x+"%'"}.join(' AND ')+')'
		end
		ilikes.join(' OR ')
	end
	
  included do
	  before_validation do 
		  self.mood.downcase!
		  user = User.find_by_id(sender_id)
		  unless user.nil?
			  parse_references!(sender_desc,user)
		    parse_references!(receiver_desc,user)
		    parse_references!(content,user)
      end
		end
		
		validates :mood, inclusion: MOODS

		def self.filtr(query)
			words = query.to_s.split('@')
	    if words.size > 1
	      descs_like(words[0],words[-1])
	    elsif !words.empty?
	      desc_like(words[0])
	    else
		    scoped
		  end
		end

		def self.moods
		  MOODS.map(&:capitalize)
		end
						
		default_scope { order('created_at DESC') }
    scope :sender_desc_like, lambda {|sender_desc|
	    where(Common.filter_sql(sender_desc,'sender_desc'))}
	
    scope :receiver_desc_like, lambda {|receiver_desc| 
	    where(Common.filter_sql(receiver_desc,'receiver_desc'))}
	
	  scope :desc_like, lambda {|desc|
		  where(Common.filter_sql(desc,['sender_desc','receiver_desc']))}
		
		scope :descs_like, lambda {|sender_desc,receiver_desc|
			sender_desc_like(sender_desc).receiver_desc_like(receiver_desc)}
			
		scope :before, lambda {|latest|
			where("created_at <= ?", latest||=Time.now)}
  end

  private
    def parse_references!(text,user)
      occs = text.scan(/&me\W/)
      occs.each do |occ|
        text.sub!(occ,'&'+user.username+occ[-1])
      end
      text.sub!(/&me\W*$/,'&'+user.username)
    end
end

class Post < ActiveRecord::Base
	include Common
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

