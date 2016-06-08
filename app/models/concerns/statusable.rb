module Statusable
  extend ActiveSupport::Concern

  MODIFIED = 1
  ADDED = 2
  DELETED = 3

  included do
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
  end
end