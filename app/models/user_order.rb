class UserOrder < ApplicationRecord
  validates :receiver_name, :address, :phone, :province, presence: true

  belongs_to :user
  has_many :orders
  has_many :products, through: :orders
  has_many :shops, through: :products
end
