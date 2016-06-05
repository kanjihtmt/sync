json.array!(@retailers) do |retailer|
  json.extract! retailer, :id, :name, :status, :created_at, :updated_at
end
