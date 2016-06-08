class Retailer < ActiveRecord::Base
  include Statusable

  has_many :sales
end
