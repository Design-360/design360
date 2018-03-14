class Chat < ApplicationRecord
    
    has_many :messages, dependent: :destroy
    has_many :subscriptions, dependent: :destroy
    has_many :chat_employees, through: :subscriptions, source: :subscriber,source_type: 'Employee'
    has_many :chat_users, through: :subscriptions, source: :subscriber,source_type: 'User'
    #if chat is destroyed all messages and subscriptions will also be  destroyed
    # has_many :subscribers, through: :subscriptions
    # validates :identifier, presence: true, uniqueness: true,    case_sensitive: false
    
end
