class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text    :description
      t.float  :price
      t.string :unit
      t.integer :in_stock
      t.json :detail
      
      t.timestamps
    end
  end
end
