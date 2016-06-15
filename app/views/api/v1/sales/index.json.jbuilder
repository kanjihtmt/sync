json.array!(@sales) do |sale|
  json.extract! sale, :id, :amount, :status, :retailer_id
  json.created_at sale.created_at.strftime('%Y-%m-%d %H:%M:%S.%6N')
  json.updated_at sale.updated_at.strftime('%Y-%m-%d %H:%M:%S.%6N')
end
