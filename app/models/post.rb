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
	  belongs_to :sender, class_name: 'User'
	
	  before_validation do 
		  self.mood.downcase!
		  unless sender.nil?
			  parse_self_references!(sender_desc)
			  parse_self_references!(receiver_desc)			
		    parse_self_references!(content)
      end
      self.sender_desc = 'anonymous' if sender_desc.empty?
      self.receiver_desc = 'anyone' if receiver_desc.empty?
		end
		
		validates :mood, inclusion: MOODS

		def self.filtr(query)
			words = query.to_s.split('@')
	    if words.size > 1
	      descs_like(words[0],words[-1])
	    elsif !words.empty?
	      desc_like(words[0])
	    else
		    all
		  end
		end

		def self.moods
		  MOODS.map(&:capitalize)
		end
						
		default_scope { order('id DESC') }
		
    scope :sender_desc_like, lambda {|sender_desc|
	    where(Common.filter_sql(sender_desc,'sender_desc'))}
	
    scope :receiver_desc_like, lambda {|receiver_desc| 
	    where(Common.filter_sql(receiver_desc,'receiver_desc'))}
	
	  scope :desc_like, lambda {|desc|
		  where(Common.filter_sql(desc,['sender_desc','receiver_desc']))}
		
		scope :descs_like, lambda {|sender_desc,receiver_desc|
			sender_desc_like(sender_desc).receiver_desc_like(receiver_desc)}
			
		scope :before, lambda {|latest|
      latest.nil? ? all : where("id <= ?", latest)}
			
    scope :after, lambda {|latest|
      latest.nil? ? all : where("id > ?", latest)}
  end

  private
    def parse_self_references!(text)
      occs = text.scan(/&me\W/)
      occs.each do |occ|
        text.sub!(occ,'&'+sender.username+occ[-1])
      end
      text.sub!(/&me\W*$/,'&'+sender.username)
    end
end

class Post < ActiveRecord::Base
	include Common

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

