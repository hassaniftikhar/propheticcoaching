class Category < ActiveRecord::Base

	# has_and_belongs_to_many :activities
	# before_destroy { activities.clear }
 # has_and_belongs_to_many :activities,
 #        :foreign_key => 'category_id',
 #        :association_foreign_key => 'activity_id',
 #        :class_name => 'Activity',
 #        :join_table => 'activities_categories'
	
 has_many :activity_categorizations, :class_name => "ActivityCategorization",
      :foreign_key => 'category_id'
 has_many :activities, through: :activity_categorizations, :class_name => "Activity",
       :foreign_key => 'activity_id'
       # , touch: true
	before_destroy {|category| category.activities.clear}

	
	has_many :ebook_categorizations, :class_name => "EbookCategorization",
      :foreign_key => 'category_id'
 has_many :ebooks, through: :ebook_categorizations, :class_name => "Ebook",
       :foreign_key => 'ebook_id'
       # , touch: true
	before_destroy {|category| category.ebooks.clear}
	# has_and_belongs_to_many :questions
	# has_and_belongs_to_many :ebooks
	# has_and_belongs_to_many :exercises
end
