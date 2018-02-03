class EmployeeMailer < ApplicationMailer
     default from: "no-reply@design360.graphics"
     
     def sample_email(user,password)
         @user = user
         @password = password
         mail(to: @user.email, subject: 'Welcome!')
     end
 end