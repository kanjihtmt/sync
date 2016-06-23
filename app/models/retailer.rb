class Retailer < ActiveRecord::Base
  include Statusable

  has_many :sales
  #
  # accepts_nested_attributes_for :sales

  after_save do
    if self.status == Retailer::DELETED
      self.sales.each do |sale|
        sale.status = Sale::DELETED
        sale.save!
      end
    end
  end
end

