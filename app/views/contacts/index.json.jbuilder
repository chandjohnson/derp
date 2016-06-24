json.array!(@contacts) do |contact|
  json.extract! contact, :id, :number, :name, :comments
  json.url contact_url(contact, format: :json)
end
