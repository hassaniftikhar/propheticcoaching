class GoogleEvent < ActiveRecord::Base
		belongs_to :profile, :polymorphic => true
end
