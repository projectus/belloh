class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, foreign_key: :sender_id
  has_many :hub_posts, foreign_key: :sender_id

  #has_attached_file :avatar, :styles => { :medium => "300x300#", :thumb => "50x50#" }, :default_url => "/images/:style/missing.jpg"

  def login=(login)
	  @login = login
	end
	
	def login
	  @login
	end

  # Code so user can log in using either username or email
  def self.find_first_by_auth_conditions(warden_conditions)
	  conditions = warden_conditions.dup
		if login = conditions.delete(:login)
		  where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
		else
			where(conditions).first
		end
	end
end
