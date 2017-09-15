class AddSlugToShops < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :slug, :string
    add_index  :shops, :slug
  end
end
