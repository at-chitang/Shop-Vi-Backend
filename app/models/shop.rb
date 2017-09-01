class Shop < ApplicationRecord
  extend FriendlyId
  friendly_id :shop_name, use: %i[slugged finders]
  validates :shop_name, :logo, :phone, :address, presence: true
  validates :shop_name, uniqueness: true

  has_many :managers
  has_many :products
  has_many :categories, through: :products
end
