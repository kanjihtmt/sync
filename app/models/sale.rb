class Sale < ActiveRecord::Base
  MODIFIED = 1
  ADDED = 2
  DELETED = 3

  scope :status, -> (type) do
    case type
      when 'modified'
        Sale.where(status: MODIFIED)
      when 'added'
        Sale.where(status: ADDED)
      when 'deleted'
        Sale.where(status: DELETED)
      else
        Sale.all
    end
  end

  belongs_to :retailer
  has_many :payments
end
