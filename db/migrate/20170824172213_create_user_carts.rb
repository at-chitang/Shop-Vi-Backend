class CreateUserCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :user_carts do |t|
      t.belongs_to :user

      t.timestamps
    end
  end
end
