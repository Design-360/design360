class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  
  has_many :orders, dependent: :destroy
  
  def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
  		user.provider = auth.provider
  		user.uid = auth.uid
  		# user.first_name = auth.info.first_name
  		# user.last_name = auth.info.last_name
  		user.email = auth.info.email
  		user.password = Devise.friendly_token[0,20]
  		user.name = auth.info.name
  		# user.picture = auth.info.image
  		return user.save,user
  	end
  end
  
end
