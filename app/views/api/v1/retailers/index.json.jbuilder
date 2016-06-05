json.array!(@retailers) do |retailer|
  json.extract! retailer, :id, :name, :created_at, :updated_at
end
