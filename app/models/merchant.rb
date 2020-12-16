class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates :name, presence: true

  def self.search(params)
    attribute = arel_table[params.keys.first]
    value = "%#{params.values.first}%"

    find_by(attribute.matches(value))
  end
end
