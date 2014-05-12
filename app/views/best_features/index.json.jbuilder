json.array!(@best_features) do |best_feature|
  json.extract! best_feature, :id, :title, :description, :image
  json.url best_feature_url(best_feature, format: :json)
end
