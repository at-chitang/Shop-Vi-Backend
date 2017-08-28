class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :child_categories, class_name: Category.name, foreign_key: :parent_id
  has_many :products
end
