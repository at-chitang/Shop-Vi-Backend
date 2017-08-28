class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string      :name
      t.float       :price
      t.belongs_to  :unit
      t.belongs_to  :shop_manager
      t.integer     :quantity_stock
      t.text        :description
      t.json        :detail

      t.timestamps
    end
  end
end
