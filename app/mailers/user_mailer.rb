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

    mail(:from => @current_user.email, :to => "makmal0014@gmail.com", :subject => subject)
  end

  def message_created(name, email, subject, message, to_eamil)
    @email     = email
    @to_email = to_eamil
    @subject  = subject
    @message  = message
    mail(:from => email, :to => to_eamil, :subject => subject, :message => message)
  end

end

