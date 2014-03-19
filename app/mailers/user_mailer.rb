class UserMailer < ActionMailer::Base
  default :from => "alerts@propheticcoaching.com"

  def registration_confirmation(user)
    mail(:to => "ijmalik@gmail.com", :subject => "Registered")
  end
end

