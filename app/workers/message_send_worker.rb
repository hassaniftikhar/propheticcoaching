class MessageSendWorker
  @queue = :emails_queue
  # def self.perform(email_id, mentee, current_user)
  def self.perform(name, email, subject, message, to_email)
    # email = EmailHistory.find(email_id)
				# UserMailer.registration_confirmation(mentee, "New Goal Created", current_user).deliver  
				# UserMailer.registration_confirmation(Mentee.find(94), "New Goal Created", User.find(2)).deliver  
				# UserMailer.goals_created(Mentee.find(94), "New Goal Created", User.find(2), email_id).deliver  
				UserMailer.message_created(name, email, subject, message, to_email).deliver 

		end
end
