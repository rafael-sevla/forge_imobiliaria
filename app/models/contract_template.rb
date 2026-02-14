class ContractTemplate < ApplicationRecord
  CONTRACT_TYPES = %w[sale rent].freeze

  has_many :contracts, dependent: :nullify

  validates :name,          presence: true, uniqueness: true
  validates :contract_type, presence: true, inclusion: { in: CONTRACT_TYPES }
  validates :content,       presence: true

  scope :for_sale, -> { where(contract_type: "sale") }
  scope :for_rent, -> { where(contract_type: "rent") }
end
