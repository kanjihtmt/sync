class Retailer < ActiveRecord::Base
  enum status: %i(default modified added deleted)

  has_many :sales
end
