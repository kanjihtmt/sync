json.extract! @payment, :id, :amount, :status, :sale_id
json.created_at @payment.created_at.strftime('%Y-%m-%d %H:%M:%S.%6N')
json.updated_at @payment.updated_at.strftime('%Y-%m-%d %H:%M:%S.%6N')
json.edited_at @payment.edited_at.nil? ? nil : @payment.edited_at.strftime('%Y-%m-%d %H:%M:%S.%6N')
