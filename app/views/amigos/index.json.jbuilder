json.array!(@amigos) do |amigo|
  json.extract! amigo, :id, :user_id, :friend_id
  json.url amigo_url(amigo, format: :json)
end
