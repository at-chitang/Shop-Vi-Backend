# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  user_name       :string(255)
#  address         :string(255)
#  gender          :integer          default(0)
#  phone           :string(255)
#  uid             :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  # on create
  has_secure_password
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'wrong email format' },
                    uniqueness: true, presence: true, on: :create

  # on update
  validate :birthday?, on: :update
  validates :phone, allow_nil: true, format: { with: /\A[0-9]{8,16}\z/, message: 'only number' }, on: :update
  validates :address, allow_nil: true, format: { with: /\A[\w\.\,\s]+\z/, message: 'only character and comma' }, on: :update
  validates :province, allow_nil: true, format: { with: /\A[\w\s]+\z/, message: 'only character' }, on: :update
  validates :zipcode, allow_nil: true, format: { with: /\A[0-9]{4,9}\z/, message: 'only number' }, on: :update

  # on create and update
  validates :first_name, :last_name, allow_nil: true, format: { with: /\A[\w\s]+\z/, message: 'only character' }

  def birthday?
    errors.add(:birthday, 'must be over 16 years old') if birthday.present? && Time.now - 16.year < birthday
  end

  enum gender: %i[Male Female Other]

  has_many :carts
  has_many :product_in_carts, through: :carts, source: :product

  def cart_detail
    query = <<-SQL
      SELECT DISTINCT
        products.name as product_name,
        products.quantity_stock,
        shops.shop_name,
        carts.quantity,
        units.name as unit
      FROM products
      INNER JOIN carts ON products.id = carts.product_id
      INNER JOIN shops ON products.shop_id = shops.id
      INNER JOIN units ON products.unit_id = units.id
      WHERE carts.user_id = 1
    SQL

    ActiveRecord::Base.connection.execute(query)
  end
end
