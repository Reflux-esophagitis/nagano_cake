class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|
      t.references :item, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :price, null: false
      t.integer :amount, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
