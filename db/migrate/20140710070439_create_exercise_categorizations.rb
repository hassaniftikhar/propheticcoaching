class CreateExerciseCategorizations < ActiveRecord::Migration
  def change
    create_table :exercise_categorizations do |t|
      t.integer :exercise_id
      t.integer :category_id

      t.timestamps
    end
  end
end
