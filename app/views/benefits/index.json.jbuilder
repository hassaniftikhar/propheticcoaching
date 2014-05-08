json.array!(@benefits) do |benefit|
  json.extract! benefit, :id, :title
  json.url benefit_url(benefit, format: :json)
end
