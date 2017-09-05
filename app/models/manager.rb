class Manager < ApplicationRecord
  before_validation :update_role, on: %i[create update]

  has_secure_password

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'wrong email format' },
                    uniqueness: true, presence: true, on: :create
  validates :manager_name, presence: true, uniqueness: { case_sensitive: true }
  validates :password, presence: true, length: { in: 6..20 }
  validates :phone, format: { with: /\A[0-9]{8,16}\z/, message: 'wrong format!' }
  validate  :validate_role

  enum gender: %w[male female other]
  enum role: %w[admin shop_manager shop_employee]

  has_many :employees, class_name: 'ShopManager', foreign_key: 'manager_id'
  # belongs_to :manager, class_name: 'ShopManager', optional: true
  belongs_to :shop, foreign_key: 'shop_id'

  private

  def validate_role
    errors.add(:manager, 'not null!') if shop_employee? && !manager_id.present?
  end

  def update_role
    self.manager_id = nil unless shop_employee?
  end
end
