class CoachMenteeRelation < ActiveRecord::Base
		self.table_name = "coach_mentee_relations"
  # belongs_to :coach
  belongs_to :coach, :class_name => "User", :foreign_key => "coach_id"
  belongs_to :mentee

		has_many :time_slots
end
