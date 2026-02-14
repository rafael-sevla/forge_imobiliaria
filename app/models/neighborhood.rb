class Neighborhood < ApplicationRecord
  belongs_to :city
  has_many :ceps, dependent: :destroy

  validates :name, presence: true
end
