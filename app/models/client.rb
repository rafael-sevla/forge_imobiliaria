class Client < ApplicationRecord
  DOCUMENT_TYPES  = %w[cpf rg cnpj].freeze
  MARITAL_STATUSES = %w[single married divorced widowed not_informed].freeze

  belongs_to :cep

  has_many :owned_properties, class_name: "Property", foreign_key: :owner_id, dependent: :restrict_with_error
  has_many :contracts_as_seller, class_name: "Contract", foreign_key: :seller_id, dependent: :restrict_with_error
  has_many :contracts_as_buyer,  class_name: "Contract", foreign_key: :buyer_id,  dependent: :restrict_with_error
  has_many :contracts_as_tenant, class_name: "Contract", foreign_key: :tenant_id, dependent: :restrict_with_error

  validates :name,            presence: true
  validates :document_type,   presence: true, inclusion: { in: DOCUMENT_TYPES }
  validates :document_number, presence: true, uniqueness: true
  validates :marital_status,  presence: true, inclusion: { in: MARITAL_STATUSES }
  validates :address_number,  presence: true
  validates :email,           format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :phones,          presence: true

  scope :individuals, -> { where(document_type: %w[cpf rg]) }
  scope :companies,   -> { where(document_type: "cnpj") }
end
