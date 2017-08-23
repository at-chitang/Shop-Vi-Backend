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
  extend FriendlyId
  friendly_id :generated_slug, use: :slugged
  require 'securerandom'
  def generated_slug
    @random_slug ||= persisted? ? friendly_id : SecureRandom.hex(15)
  end

  # on create
  has_secure_password
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'wrong email format' },
                    uniqueness: true, presence: true, on: :create

  # on update
  validates :first_name, allow_nil: true, format: { with: /\A[\w\s]+\z/, message: 'only character' }, on: :update
  validates :last_name, allow_nil: true, format: { with: /\A[\w\s]+\z/, message: 'only character' }, on: :update
  validate :birthday?, on: :update
  validates :phone, allow_nil: true, format: { with: /\A[0-9]{8,16}\z/, message: 'only number' }, on: :update
  validate :gender?, on: :update
  validates :address, allow_nil: true, format: { with: /\A[\w\.\,\s]+\z/, message: 'only character and comma' }, on: :update
  validates :province, allow_nil: true, format: { with: /\A[\w\s]+\z/, message: 'only character' }, on: :update
  validates :phone, allow_nil: true, format: { with: /\A[0-9]{4,9}\z/, message: 'only number' }, on: :update

  def birthday?
    errors.add(:birthday, 'must be over 16 years old') if birthday.present? && Time.now - 16.year < birthday
  end

  def gender?
    # binding.pry
    errors.add(:gender, 'must be between 0 - 2') unless gender.between(0..2)
  end

  # after_initialize :defaults, unless: :persisted?

  # def defaults
  #   self.gender ||= 0
  # end

  enum gender: ['Nam', 'Nữ', 'Ngại quá à']
end
