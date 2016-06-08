class Sale < ActiveRecord::Base
  MODIFIED = 1
  ADDED = 2
  DELETED = 3

  scope :status, -> (type) do
    case type
      when 'modified'
        self.where(status: MODIFIED)
      when 'added'
        self.where(status: ADDED)
      when 'deleted'
        self.where(status: DELETED)
      else
        self.all
    end
  end

  belongs_to :retailer
  has_many :payments
end
