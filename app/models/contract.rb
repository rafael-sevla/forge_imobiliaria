class Contract < ApplicationRecord
  CONTRACT_TYPES   = %w[sale rent].freeze
  STATUSES         = %w[active completed cancelled].freeze

  belongs_to :property
  belongs_to :seller,            class_name: "Client"
  belongs_to :buyer,             class_name: "Client", optional: true
  belongs_to :tenant,            class_name: "Client", optional: true
  belongs_to :contract_template, optional: true

  has_many :payments, dependent: :restrict_with_error

  validates :contract_number, presence: true, uniqueness: true
  validates :contract_type,   presence: true, inclusion: { in: CONTRACT_TYPES }
  validates :status,          presence: true, inclusion: { in: STATUSES }
  validates :start_date,      presence: true
  validate  :buyer_or_tenant_required
  validate  :sale_fields_present,   if: -> { contract_type == "sale" }
  validate  :rental_fields_present, if: -> { contract_type == "rent" }
  validate  :end_date_after_start_date, if: -> { start_date.present? && end_date.present? }

  scope :active,    -> { where(status: "active") }
  scope :sales,     -> { where(contract_type: "sale") }
  scope :rentals,   -> { where(contract_type: "rent") }

  def sale?
    contract_type == "sale"
  end

  def rent?
    contract_type == "rent"
  end

  def total_paid
    payments.sum(:amount)
  end

  private

  def buyer_or_tenant_required
    if contract_type == "sale" && buyer.blank?
      errors.add(:buyer, "é obrigatório em contratos de venda")
    elsif contract_type == "rent" && tenant.blank?
      errors.add(:tenant, "é obrigatório em contratos de locação")
    end
  end

  def sale_fields_present
    errors.add(:sale_price, "deve ser maior que zero") if sale_price.to_d <= 0
  end

  def rental_fields_present
    errors.add(:rental_fee, "deve ser maior que zero") if rental_fee.to_d <= 0
    if rental_due_day.blank? || rental_due_day < 1 || rental_due_day > 28
      errors.add(:rental_due_day, "deve ser entre 1 e 28")
    end
  end

  def end_date_after_start_date
    errors.add(:end_date, "deve ser posterior à data de início") if end_date < start_date
  end
end
