class Shop < ApplicationRecord
  validates :shop_name, :logo, :phone, :address, presence: true
  validates :shop_name, uniqueness: true

  has_many :managers
  has_many :products
end
