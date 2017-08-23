class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :phone
      t.integer :gender, default: 0
      t.string :address
      t.string :province
      t.string :zipcode
      # t.string :country
      t.string :uid
      t.string :auth_token
      t.string :token
      t.date :confirm_at
      t.datetime :create_token_at

      t.timestamps
    end
  end
end
