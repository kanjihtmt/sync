json.extract! @retailer, :id, :name, :status
json.created_at @retailer.created_at.strftime('%Y-%m-%d %H:%M:%S.%6N')
json.updated_at @retailer.updated_at.strftime('%Y-%m-%d %H:%M:%S.%6N')
