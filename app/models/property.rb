class Property < ApplicationRecord
  belongs_to :cep
  belongs_to :owner, class_name: "Client"

  has_many :contracts, dependent: :restrict_with_error

  validates :title,           presence: true
  validates :address_number,  presence: true
  validates :sale_price,      numericality: { greater_than_or_equal_to: 0 }
  validates :commission_on_sales,   numericality: { greater_than_or_equal_to: 0 }
  validates :rental_fee,      numericality: { greater_than_or_equal_to: 0 }
  validates :rental_deposit,  numericality: { greater_than_or_equal_to: 0 }
  validates :commission_on_rentals, numericality: { greater_than_or_equal_to: 0 }
  validates :penalty_for_each_day_of_rent_overdue, numericality: { greater_than_or_equal_to: 0 }
  validates :rental_fee_due_day, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 28 }
  validates :area, numericality: { greater_than: 0 }, allow_nil: true
  validate  :available_for_at_least_one_purpose

  scope :for_sale, -> { where(is_for_sale: true) }
  scope :for_rent, -> { where(is_for_rent: true) }

  def active_rental_contract
    contracts.where(contract_type: "rent", status: "active").order(start_date: :desc).first
  end

  def current_tenant
    active_rental_contract&.tenant
  end

  private

  def available_for_at_least_one_purpose
    return if is_for_sale? || is_for_rent?

    errors.add(:base, "O imóvel deve estar disponível para venda ou locação")
  end
end
