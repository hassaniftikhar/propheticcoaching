class CreateBestFeatures < ActiveRecord::Migration
  def change
    create_table :best_features do |t|
      t.string :title
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
