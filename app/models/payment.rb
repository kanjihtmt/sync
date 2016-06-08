class Payment < ActiveRecord::Base
  include Statusable

  has_one :retailer
  belongs_to :sale
end
