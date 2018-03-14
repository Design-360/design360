class EmployeeMailer < ApplicationMailer
     default from: "no-reply@design360.graphics"
     
     def welcome_email(user,password)
         @user = user
         @password = password
         mail(to: @user.email, subject: 'Welcome!')
     end
     
     def asign_email(user)
         @user = user
         mail(to: @user.email, subject: 'Assignment')
     end
     
     def notification_email(notification)
          @notification = notification
          email_subject = 'Update in Order Status' if notification.notify_type=='Order'
          email_subject = 'You have Recieved a new Message' if notification.notify_type=='Message'
          mail(to: @notification.recipient.email, subject: email_subject)
     end
end