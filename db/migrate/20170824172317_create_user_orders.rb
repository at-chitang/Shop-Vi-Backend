class CreateUserOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :user_orders do |t|
      t.belongs_to  :user
      t.float       :total
      t.string      :receiver_name
      t.string      :address
      t.string      :phone
      t.string      :province

      t.timestamps
    end
  end
end
