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
end