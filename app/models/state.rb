class State < ApplicationRecord
  has_many :cities, dependent: :destroy

  validates :name, presence: true
  validates :abbreviation, presence: true, length: { is: 2 }, uniqueness: true
end
