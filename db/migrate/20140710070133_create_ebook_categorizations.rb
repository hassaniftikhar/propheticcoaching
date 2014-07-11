class CreateEbookCategorizations < ActiveRecord::Migration
  def change
    create_table :ebook_categorizations do |t|
      t.integer :ebook_id
      t.integer :category_id

      t.timestamps
    end
  end
end
