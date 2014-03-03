json.array!(@accomplishments) do |accomplishment|
  json.extract! accomplishment, :id, :body, :mentee_id
  json.url accomplishment_url(accomplishment, format: :json)
end
