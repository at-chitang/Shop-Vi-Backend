class Unit < ApplicationRecord
  validates :name, uniqueness: true, presence: true, on: :create

  has_many :products, class_name: :Product
end
