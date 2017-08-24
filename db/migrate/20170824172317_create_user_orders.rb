class CreateUserOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :user_orders do |t|
      t.belongs_to :user

      t.timestamps
    end
  end
end
