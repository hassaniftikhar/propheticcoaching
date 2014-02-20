json.array!(@email_histories) do |email_history|
  json.extract! email_history, :id, :body, :mentee_id
  json.url email_history_url(email_history, format: :json)
end
