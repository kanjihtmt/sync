json.array!(@user) do |user|
  json.extract! user, :id, :name, :telephone, :created_at, :updated_at
end
