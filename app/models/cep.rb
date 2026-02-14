class Cep < ApplicationRecord
  belongs_to :neighborhood

  validates :cep, presence: true, uniqueness: true, length: { maximum: 10 }
  validates :street, presence: true
end
