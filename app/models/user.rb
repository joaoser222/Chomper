class User < ApplicationRecord
  include Filterable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :registerable,
  :database_authenticatable,
  :recoverable,
  :jwt_authenticatable,
  jwt_revocation_strategy: self

  has_many :adverts, dependent: :destroy

  validates :name,
            length: { in: 5..50 },
            presence: true,
            allow_nil: :updated_at_changed?

  validates :password,
            presence: true,
            confirmation: true,
            length: { minimum: 8 },
            allow_nil: :updated_at_changed?

  validates :email,
            length: { maximum: 260 },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i},
            uniqueness: { case_sensitive: false },
            allow_nil: :updated_at_changed?

  validates :phone,
            format: { with: /\d[0-9]\)*\z/},
            length: { is: 14 },
            allow_nil: true

  validates :document,
            format: { with: /(^\d{3}\.\d{3}\.\d{3}\-\d{2}$)|(^\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}$)/ },
            length: { minimum: 14, maximum: 20 },
            allow_nil: true

  validates :state,
            length: { is: 2 },
            allow_nil: true

  validates :city,
            length: { in: 2..260 },
            allow_nil: true

  validates :district,
            length: { in: 2..260 },
            allow_nil: true    

  validates :street,
            length: { in: 2..260 },
            allow_nil: true

  validates :radius,
            numericality: { only_integer: true },
            presence: true,
            allow_nil: :updated_at_changed?

  validates :latitude,
            numericality: true,
            presence: true,
            allow_nil: :updated_at_changed?

  validates :longitude,
            numericality: true,
            presence: true,
            allow_nil: :updated_at_changed?

  validates :kind,
            presence: true,
            inclusion: {in: %w(admin customer company)},
            allow_nil: :updated_at_changed?

  before_save { 
    self.email = email.downcase
    self.radius = 0 if kind == "customer"
  }

end
