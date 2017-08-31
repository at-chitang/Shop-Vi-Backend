class Cart < ApplicationRecord
  validates :quantity, numericality: { only_integer: true }
  validates :product_id, uniqueness: { scope: :year, message: 'should update quantity' }

  belongs_to :user
  belongs_to :product

  def product_detail
    Product.select(:name, :price, :quantity_stock, ).find_by(id: product_id)
  end
end
