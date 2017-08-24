class ShopManager < ApplicationRecord
  before_validation :update_role, on: %i[create update]

  validates :username, presence: true, uniqueness: { case_sensitive: true }
  validates :password, presence: true, length: { in: 6..20 }
  validates :phone, format: { with: /\d[0-9]\)*\z/, message: 'wrong format!' }
  validate  :validate_role

  enum gender: %w[male female other]
  enum role: %w[admin shop_manager shop_employee]

  has_many :employees, class_name: 'ShopManager', foreign_key: 'manager_id'
  belongs_to :manager, class_name: 'ShopManager', optional: true
  belongs_to :shop, foreign_key: 'shop_id'

  has_secure_password

  private

  def validate_role
    errors.add(:manager, 'not null!') if shop_employee? && !manager_id.present?
  end

  def update_role
    self.manager_id = 0 unless shop_employee?
  end
end
