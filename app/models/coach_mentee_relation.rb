class CoachMenteeRelation < ActiveRecord::Base
		self.table_name = "coaches_mentees_joins"
  # belongs_to :coach
  belongs_to :coach, :class_name => "User", :foreign_key => "coach_id"
  belongs_to :mentee

		# has_many :time_slots
		has_many :events
end
