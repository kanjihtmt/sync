json.array!(@sales) do |sale|
  json.extract! sale, :id, :amount, :status, :retailer_id, :created_at, :updated_at
end
