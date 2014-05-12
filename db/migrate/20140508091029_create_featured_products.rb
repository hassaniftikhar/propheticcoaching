class CreateFeaturedProducts < ActiveRecord::Migration
  def change
    create_table :featured_products do |t|
      t.string :title
      t.text :description
      t.string :image
      t.decimal :price
      t.string :profile_id
      t.string :profile_type

      t.timestamps
    end
  end
end
