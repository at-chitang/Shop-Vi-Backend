class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: true }

  has_many :products
end
