class Payment < ApplicationRecord
  PAYMENT_METHODS = %w[cash credit_card debit_card bank_transfer pix].freeze

  belongs_to :contract

  validates :amount,         presence: true, numericality: { greater_than: 0 }
  validates :payment_date,   presence: true
  validates :payment_method, presence: true, inclusion: { in: PAYMENT_METHODS }

  scope :by_date,   -> { order(payment_date: :asc) }
  scope :in_period, ->(from, to) { where(payment_date: from..to) }
end
