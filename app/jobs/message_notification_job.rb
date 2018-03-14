class MessageNotificationJob < ApplicationJob
  queue_as :default

  def perform(message)
    chat = message.chat
    chat_last_message = chat.messages.order('created_at DESC').first
    time_diff = message.created_at - chat_last_message.created_at
    time_diff_min = time_diff.to_i/60
    recipient_user = chat.subscriptions.where.not(subscriber: message.message_sender).first.subscriber
    
    logger.info "---------------"
    logger.info time_diff_min
    logger.info "---------------"
    if time_diff_min >= 10
      Notification.create!(notify: message,actor: message.message_sender,recipient: recipient_user ,status: "created")
    end
  end
end
