class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders]
  validates :name, presence: true, uniqueness: true

  belongs_to :parent, class_name: Category.name, foreign_key: :parent_id, optional: true
  has_many :children, class_name: Category.name, foreign_key: :parent_id
  has_many :products
end
