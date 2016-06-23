class AddEditedAtColumn < ActiveRecord::Migration
  def change
    add_column :retailers, :edited_at, :datetime
    add_column :payments, :edited_at, :datetime
    add_column :sales, :edited_at, :datetime
  end
end
