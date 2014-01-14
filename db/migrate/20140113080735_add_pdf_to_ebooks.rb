class AddPdfToEbooks < ActiveRecord::Migration
  def change
    add_column :ebooks, :pdf, :string
  end
end
