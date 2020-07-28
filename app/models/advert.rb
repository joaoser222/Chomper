class Advert < ApplicationRecord
  include Filterable
  belongs_to :user
  validates :name,
            length: { in: 5..50 },
            presence: true,
            allow_nil: :updated_at_changed?

  validates :description,
            length: { in: 10..100 },
            presence: true,
            allow_nil: :updated_at_changed?

  validates :price,
            presence: true,
            numericality: true,
            allow_nil: :updated_at_changed?

  validates :status,
            length: { is: 1 },
            presence: true,
            allow_nil: :updated_at_changed?
end
