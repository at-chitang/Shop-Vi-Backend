class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :child_categories, class_name: Category.name, foreign_key: :parent_id
  belongs_to :parent, class_name: Category.name, foreign_key: :parent_id, optional: true
  has_many :products
end
