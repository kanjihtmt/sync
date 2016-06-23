class Sale < ActiveRecord::Base
  include Statusable

  belongs_to :retailer
  has_many :payments

  after_save do
    if self.status == DELETED
      self.payments.each do |payment|
        payment.status = DELETED
        payment.save!
      end
    end
  end
end
