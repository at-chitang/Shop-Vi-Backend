class Shop < ApplicationRecord
  validates :name, :logo, :phone, :address, presence: true
  validates :name, uniqueness: { case_sensitive: true }

  has_many :shop_managers
end
