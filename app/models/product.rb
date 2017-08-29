class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged finders]

  validates :name, presence: true
  validates :price, :quantity_stock, :description, :detail, presence: true

  belongs_to :unit
  belongs_to :shop
  belongs_to :category
  has_many :product_images

  def shop_name
    Shop.find(shop_id).shop_name
  end

  def slug_candidates
    %i[name shop_name id]
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
