json.array!(@payments) do |payment|
  json.extract! payment, :id, :amount, :status, :sale_id, :created_at, :updated_at
end
