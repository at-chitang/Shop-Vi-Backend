class Cart < ApplicationRecord
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :product_id, uniqueness: { scope: :user_id, message: 'should update quantity' }, on: :create

  belongs_to :user
  belongs_to :product
  has_one :shop, through: :product
  has_one :product_image, through: :product

  def product_detail
    Product.select(:slug, :name, :price, :quantity_stock).find_by(id: product_id).as_json
           .merge(shop: shop.as_json.slice('shop_name', 'slug'))
  end
end
