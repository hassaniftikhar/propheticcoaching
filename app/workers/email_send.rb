class EmailSend
	@queue = :emails_queue
  # def self.perform(email_id, mentee, current_user)
  def self.perform(email_id, current_user_id, subject)
    # email = EmailHistory.find(email_id)
				# UserMailer.registration_confirmation(mentee, "New Goal Created", current_user).deliver  
				# UserMailer.registration_confirmation(Mentee.find(94), "New Goal Created", User.find(2)).deliver  
				# UserMailer.goals_created(Mentee.find(94), "New Goal Created", User.find(2), email_id).deliver 

				p "=============== EmailSend perform " 
				UserMailer.email_created(subject, current_user_id, email_id).deliver 

			end
		end
