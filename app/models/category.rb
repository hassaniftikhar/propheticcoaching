class Category < ActiveRecord::Base

	has_and_belongs_to_many :activities
	has_and_belongs_to_many :questions
	has_and_belongs_to_many :ebooks
	has_and_belongs_to_many :exercises
 # has_and_belongs_to_many :activities,
 #        :foreign_key => 'category_id',
 #        :association_foreign_key => 'activity_id',
 #        :class_name => 'Activity',
 #        :join_table => 'activities_categories'
end
