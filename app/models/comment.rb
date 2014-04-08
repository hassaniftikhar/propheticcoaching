class Comment < ActiveRecord::Base

		self.table_name = "active_admin_comments"
		belongs_to :resource, :polymorphic => true

  def deliver_email(current_user, subject)
    email = self.resource.email_histories.new
    email.body = self.body
    if email.save
      Resque.enqueue(EmailSend, email.id, current_user.id, subject)
    end
  end
end
