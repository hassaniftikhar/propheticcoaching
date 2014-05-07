json.array!(@activities) do |activity|
  json.extract! activity, :id, :body, :last_import
  json.url activity_url(activity, format: :json)
end
