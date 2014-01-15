json.array!(@mentees) do |mentee|
  json.extract! mentee, :id, :index, :show
  json.url mentee_url(mentee, format: :json)
end
