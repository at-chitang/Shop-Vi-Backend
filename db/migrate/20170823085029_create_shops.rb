class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string      :name
      t.string      :logo
      t.string      :phone
      t.string      :address
      t.integer     :status, default: 0
      t.timestamps
    end
  end
end
