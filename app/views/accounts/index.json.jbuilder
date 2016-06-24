json.array!(@accounts) do |account|
  json.extract! account, :id, :user, :level
  json.url account_url(account, format: :json)
end
