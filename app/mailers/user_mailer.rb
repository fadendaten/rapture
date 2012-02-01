class UserMailer < ActionMailer::Base
  

  default from: "no-reply@fadendaten.ch"
  
  def welcome_email(user)
      @user = user
      @url = "http://localhost:3000"
      welcome_subject = "Herzliche Gratulation zu ihrem brandneuen rapture-Account!"
      mail(:to => user.email, :subject => welcome_subject)
    end
  
end
