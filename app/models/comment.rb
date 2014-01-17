class Comment < ActiveRecord::Base

		self.table_name = "active_admin_comments"
		belongs_to :resource, :polymorphic => true

end
