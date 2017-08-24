class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to  :user
      t.belongs_to  :product
      t.text        :content

      t.timestamps
    end
  end
end
