class City < ApplicationRecord
  belongs_to :state
  has_many :neighborhoods, dependent: :destroy

  validates :name, presence: true
end
