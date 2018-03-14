class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  
  before_destroy :reset_order
  has_many :employee_orders, dependent: :destroy
  has_many :orders, through: :employee_orders
  enum role: [ :admin, :manager]
  has_many :messages, :as => :message_sender
  has_many :subscriptions, as: :subscriber
  has_many :chats,  through: :subscriptions, as: :subscriber
  has_many :order_users, through: :orders, source: :user
  has_many :notifications, as: :recipient
  
  has_many :chatted_users ,through: :chats, source: :subscriptions
  has_many :chatted_employees , through: :chatted_users, source: :subscriber, source_type: 'Employee'
  
  
  # scope :mychatted_employees, -> { where.not(id: 1 ) }
  # has_many :friends, -> { where status: 'accepted' }, :through => :friendships , :order => :first_name
  
  def reset_order
    employee_orders = EmployeeOrder.where(:employee_id => self.id)
      
    employee_orders.each do |eorder|
      order = Order.find(eorder.order_id)
      if order.status == "assigned" or order.status == "in_revision"
        order.update(:status => "pending")
      end
    end
  end
  
  
  def chatted_with?(user)
    chats = self.chats.includes(subscriptions: [:subscriber])
    chats.each do |chat|
      chatted = chat.subscriptions.pluck(:subscriber_type,:subscriber_id)
      logger.info chatted
      return [true,chat] if chatted.include?([user.class.to_s, user.id])
    end
    return [false,nil]
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
end
