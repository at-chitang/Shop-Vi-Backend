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
  validate :birthday?, allow_nil: true, on: :update
  validates :phone, allow_nil: true, format: { with: /\A[0-9]{8,16}\z/, message: 'only number' }, on: :update
  validates :address, allow_nil: true, format: { with: /\A[\w\.\,\s]+\z/, message: 'only character and comma' }, on: :update
  validates :province, allow_nil: true, format: { with: /\A[\w\s]+\z/, message: 'only character' }, on: :update
  validates :zipcode, allow_nil: true, format: { with: /\A[0-9]{4,9}\z/, message: 'only number' }, on: :update

  # on create and update
  validates :first_name, :last_name, allow_nil: true, format: { with: /\A[\w\s]+\z/, message: 'only character' }

  def birthday?
    errors.add(:birthday, 'must be over 16 years old') if birthday.present? && Time.now - 16.year < birthday
  end

  enum gender: ['Nam', 'Nữ', 'Ngại quá à']
end
