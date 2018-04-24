class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  enum subscribed: [:not_subscribe,:subscribe,:cancelled]
  
  has_many :orders, dependent: :destroy
  has_one :plan_subscriber, dependent: :destroy
  has_one :plan, through: :plan_subscriber
  
  has_many :messages, :as => :message_sender
  has_many :subscriptions, as: :subscriber
  has_many :chats,  through: :subscriptions, as: :subscriber
  has_many :chatted_users ,through: :chats, source: :subscriptions
  has_many :order_employee_orders,through: :orders, source: :employee_order
  has_many :order_managers,through: :order_employee_orders, source: :employee
  has_many :notifications, as: :recipient
  serialize :stripe_response, JSON
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
  
  def chatted_with?(user)
    chats = self.chats.includes(subscriptions: [:subscriber])
    chats.each do |chat|
      chatted = chat.subscriptions.pluck(:subscriber_type,:subscriber_id)
      return [true,chat] if chatted.include?([user.class.to_s, user.id])
    end
    a = [false,nil]
    
    return a
  end
  
  def chat_with(user)
    if self.chatted_with?(user)
      chats = self.chats.includes(subscriptions: [:subscriber])
      chats.each do |chat|
        chatted = chat.subscriptions.pluck(:subscriber_type,:subscriber_id)
        # logger.info chatted
        return chat if chatted.include?([user.class.to_s, user.id])
      end
    else
      return nil
    end
    
  end
  
  def invoice
    Stripe::Invoice.list(customer:self.stripe_response["id"])   
  end
  
  def delete_stripe_customer
    Stripe::Customer.retrieve(self.stripe_response["id"]).delete if stripe_response
    self.plan_subscriber.update!(stripe_response:nil) if self.plan_subscriber
    self.update!(stripe_response:nil)
    self.not_subscribe!
  end
  
  
end
