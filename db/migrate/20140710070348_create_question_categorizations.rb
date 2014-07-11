class CreateQuestionCategorizations < ActiveRecord::Migration
  def change
    create_table :question_categorizations do |t|
      t.integer :question_id
      t.integer :category_id

      t.timestamps
    end
  end
end
