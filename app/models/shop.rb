class Shop < ApplicationRecord
  validates :name, :logo, :phone, :address, presence: true
  validates :name, uniqueness: true

  has_many :shop_managers
  has_many :product
end
