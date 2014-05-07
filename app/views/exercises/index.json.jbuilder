json.array!(@exercises) do |exercise|
  json.extract! exercise, :id, :body, :last_import
  json.url exercise_url(exercise, format: :json)
end
