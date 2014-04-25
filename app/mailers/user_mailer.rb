class UserMailer < ActionMailer::Base
  # default :from => "alerts@propheticcoaching.com"
	# default :subject => "Registered" 


  def registration_confirmation(user, subject, current_user)
    mail(:from => current_user.email, :to => user.email, :subject => subject)
  end

  def email_created(subject, current_user_id, email_id)
  		@email = EmailHistory.find(email_id)
  		@user = @email.mentee
      @current_user = User.find(current_user_id)

      p "email =========================="
      p @current_user.email
      p "email =========================="
    mail(:from => @current_user.email, :to => @user.email, :subject => subject)
  end
end

