class MessageSendingJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    ActionCable.server.broadcast "chat_id_#{message.chat_id}", {message: render_message(message), sender_type: message.message_sender.class.to_s,sender_id: message.message_sender.id}
  end
  
  private
   
  def render_message(message)
      MessagesController.render partial: 'messages/message', locals: { message: message }
  end
  
end
