class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :amount
      t.integer :status
      t.integer :retailer_id

      t.timestamps null: false
    end
  end
end
