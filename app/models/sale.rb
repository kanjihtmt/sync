class Sale < ActiveRecord::Base
  include Statusable

  belongs_to :retailer
  has_many :payments
end
