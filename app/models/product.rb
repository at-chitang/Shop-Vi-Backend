class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, :quantity_stock, :description, :detail, presence: true

  belongs_to :unit
  belongs_to :shop
  has_many :product_images
  # belongs_to :categories
end
