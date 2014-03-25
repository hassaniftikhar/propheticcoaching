class Goal < ActiveRecord::Base

  belongs_to :mentee


  def deliver_email
    email = self.mentee.email_histories.new
    email.body = self.body

    if email.save
      Resque.enqueue(EmailSend, email.id)
    end
  end

end
