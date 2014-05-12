json.array!(@featured_products) do |featured_product|
  json.extract! featured_product, :id, :title, :description, :image, :price, :profile_id, :profile_type
  json.url featured_product_url(featured_product, format: :json)
end
