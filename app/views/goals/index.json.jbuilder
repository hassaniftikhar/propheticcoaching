json.array!(@goals) do |goal|
  json.extract! goal, :id, :body
  json.url goal_url(goal, format: :json)
end
