class UserMailer < ActionMailer::Base
  default :from => "alerts@propheticcoaching.com"
		default :subject => "Registered" 


  def registration_confirmation(user, subject, current_user)
    mail(:from => current_user.email, :to => user.email, :subject => subject)
  end

  def goals_created(subject, current_user, email_id)
  		@email = EmailHistory.find(email_id)
  		@user = @email.mentee

    mail(:from => current_user.email, :to => @user.email, :subject => subject)
  end
end
