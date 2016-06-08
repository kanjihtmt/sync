class Retailer < ActiveRecord::Base
  MODIFIED = 1
  ADDED = 2
  DELETED = 3

  scope :status, -> (type) do
    case type
      when 'modified'
         Retailer.where(status: MODIFIED)
      when 'added'
         Retailer.where(status: ADDED)
      when 'deleted'
         Retailer.where(status: DELETED)
      else
         Retailer.all
    end
  end

  has_many :sales
end
