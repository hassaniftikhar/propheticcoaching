json.array!(@contact_requests) do |contact_request|
  json.extract! contact_request, :id, :subject, :first_name, :last_name, :email, :phone_no, :contact_mode, :city, :state_country, :website, :heard_mode, :purpose, :message
  json.url contact_request_url(contact_request, format: :json)
end
