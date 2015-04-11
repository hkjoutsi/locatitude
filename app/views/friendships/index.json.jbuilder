json.array!(@friendships) do |friendship|
  json.extract! friendship, :id, :requestor_id, :requestee_id
  json.url friendship_url(friendship, format: :json)
end
