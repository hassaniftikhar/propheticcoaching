class AddUrlColumnToFeaturedProducts < ActiveRecord::Migration
  def change
  	add_column :featured_products, :url, :string
  end
end
