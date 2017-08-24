class Unit < ApplicationRecord
  validates :name, uniqueness: true, presence: true, on: :create

  belongs_to :product, class_name: :Product
end
