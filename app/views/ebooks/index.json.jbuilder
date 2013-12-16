json.array!(@ebooks) do |ebook|
  json.extract! ebook, :id, :name
  json.url ebook_url(ebook, format: :json)
end
