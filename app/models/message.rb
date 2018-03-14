class Message < ApplicationRecord
    belongs_to :message_sender, :polymorphic => true
    belongs_to :chat
    has_many :notifications, as: :notify
    has_attached_file :document
  validates_attachment :document, content_type: { content_type: ["application/pdf",'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', "image/jpeg", "image/gif", "image/png", "image/jpg", "image/bmp"] }
    
    after_create_commit :jobs
    after_create_commit :send_message_notification
#     { 
#     #  ActionCable.server.broadcast "chat_id_#{self.chat_id}", render_message(self)
#     MessageSendingJob.perform_later(self)
#   }
   
   def jobs
       MessageSendingJob.perform_later(self)
    #   MessageNotificationJob.perform_later(self)
   end
   
   def send_message_notification
        message = self
        chat = message.chat
        recipient_user = chat.subscriptions.select{|p| p.subscriber!= message.message_sender}.first.subscriber
        excluding_me = chat.messages.where.not(id: message.id)
        if excluding_me.blank?
            Notification.create!(notify: message,actor: message.message_sender,recipient: recipient_user ,status: "created")
        else
            chat_last_message = excluding_me.order('created_at DESC').first if not excluding_me.blank?
        
            time_diff = message.created_at - chat_last_message.created_at
            time_diff_min = time_diff.to_i/60
            if time_diff_min >= 10
              Notification.create!(notify: message,actor: message.message_sender,recipient: recipient_user ,status: "created")
            end
        end
            
        
   end
   
#   private
   
#   def render_message(message)
#       MessagesController.render partial: 'messages/message', locals: { message: message }
#   end
    
    
end
