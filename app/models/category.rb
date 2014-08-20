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


 has_many :question_categorizations, :class_name => "QuestionCategorization",
      :foreign_key => 'category_id'
 has_many :questions, through: :question_categorizations, :class_name => "Question",
       :foreign_key => 'question_id'
       # , touch: true
	before_destroy {|category| category.activities.clear}

 has_many :exercise_categorizations, :class_name => "ExerciseCategorization",
      :foreign_key => 'category_id'
 has_many :exercises, through: :exercise_categorizations, :class_name => "Exercise",
       :foreign_key => 'exercise_id'
       # , touch: true
	before_destroy {|category| category.activities.clear}


   # def self.duplicate_category
   #  # find all models and group them on keys which should be common
   #  grouped = all.group_by{|category| [category.name] }
   #  grouped.values.each do |duplicates|
   #    # the first one we want to keep right?
   #    first_one = duplicates.shift # or pop for last one
   #    # if there are any more left, they are duplicates
   #    # so delete all of them
   #    duplicates.each{|double| double.destroy} # duplicates can now be destroyed
   #  end
   # end
end
