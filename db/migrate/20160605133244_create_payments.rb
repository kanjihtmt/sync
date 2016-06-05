class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :amount
      t.integer :status
      t.integer :sale_id

      t.timestamps null: false
    end
  end
end
