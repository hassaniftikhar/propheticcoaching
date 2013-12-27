json.array!(@coaches) do |coach|
  json.extract! coach, :id, :index, :show
  json.url coach_url(coach, format: :json)
end
