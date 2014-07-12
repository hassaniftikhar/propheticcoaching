class QuestionCategorization < ActiveRecord::Base

  belongs_to :category
  belongs_to :question

end
