class Order < ApplicationRecord
  belongs_to :user_order
  belongs_to :product
  has_one :user, through: :user_order
  has_one :shop, through: :product
  has_one :product_image, through: :product
end
