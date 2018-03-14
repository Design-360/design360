class NotificationJob < ApplicationJob
  queue_as :default

  def perform(notification)
    # Do something later
    ActionCable.server.broadcast "notification_#{notification.recipient_type}_#{notification.recipient_id}", render_message(notification)
  end
  
  private
   
  def render_message(notification)
      ApplicationController.render partial: 'notifications/notification', locals: { notification: notification }
  end
end
