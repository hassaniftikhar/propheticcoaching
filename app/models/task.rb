class Task < ActiveRecord::Base

	belongs_to :mentee
	
	def deliver_email(current_user, subject)
		p "=============== Task :: deliver_email"
		email = self.mentee.email_histories.new
		email.body = self.description + "\n Start Time: " + self.starttime.strftime("%b %d, %Y %I:%M %p").to_s + "\n End Time: " + self.endtime.strftime("%b %d, %Y %I:%M %p").to_s + "\n Status: " +self.status
		if email.save
			Resque.enqueue(EmailSend, email.id, current_user.id, subject)
		end
	end
end

