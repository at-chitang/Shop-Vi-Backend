class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to  :user_order
      t.belongs_to  :product
      t.integer     :quantity
      t.float       :price

      t.timestamps
    end
  end
end
