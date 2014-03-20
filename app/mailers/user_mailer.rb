class UserMailer < ActionMailer::Base
  default :from => "alerts@propheticcoaching.com"

  def registration_confirmation(user)
    mail(:to => user.email, :subject => "Registered")
  end
end

