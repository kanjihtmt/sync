class Payment < ActiveRecord::Base
  has_one :retailer
  belongs_to :sale
end
