class Sale < ActiveRecord::Base
  belongs_to :retailer
  has_many :payments
end
