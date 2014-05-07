class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.text :body
      t.boolean :last_import

      t.timestamps
    end
  end
end
