class CreateManagers < ActiveRecord::Migration[5.1]
  def change
    create_table :managers do |t|
      t.string      :email
      t.string      :manager_name
      t.string      :password_digest
      t.integer     :role,            default: 1
      t.integer     :gender,          default: 0
      t.string      :avatar
      t.string      :phone
      t.references  :manager,         index: true
      t.references  :shop,            index: true

      t.timestamps
    end
  end
end
