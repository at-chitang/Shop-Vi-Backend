class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, :quantity_stock, :description, :detail, presence: true

  has_many :unit
  has_many :shop_manager
  belongs_to :categori
  belongs_to :shop
end
