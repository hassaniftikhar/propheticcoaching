json.array!(@videos) do |video|
  json.extract! video, :id, :title, :path
  json.url video_url(video, format: :json)
end
