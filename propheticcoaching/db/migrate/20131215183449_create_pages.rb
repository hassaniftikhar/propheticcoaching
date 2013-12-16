class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.belongs_to :ebook
      t.string :page_number
      t.text :tags

      t.timestamps
    end
  end
end
