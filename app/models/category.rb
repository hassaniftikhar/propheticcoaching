class Category < ActiveRecord::Base

	has_and_belongs_to_many :activities
	# has_and_belongs_to_many :questions
	# has_and_belongs_to_many :ebooks
	# has_and_belongs_to_many :exercises
	
end
