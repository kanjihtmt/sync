json.extract! @payment, :id, :amount, :status, :sale_id
json.created_at @payment.created_at.strftime('%Y-%m-%d %H:%M:%S.%6N')
json.updated_at @payment.updated_at.strftime('%Y-%m-%d %H:%M:%S.%6N')