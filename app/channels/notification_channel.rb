class NotificationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    if params[:user].present?
      logger.add_tags params
      stream_from "notification_#{params[:user]}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
