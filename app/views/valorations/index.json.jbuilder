json.array!(@valorations) do |valoration|
  json.extract! valoration, :id, :user_id, :post_id, :calificacion
  json.url valoration_url(valoration, format: :json)
end
