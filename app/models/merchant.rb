class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates :name, presence: true

  def self.single_search(attribute, value)
    if attribute == 'created_at' || attribute == 'updated_at'
      find_by("DATE(#{attribute}) = '%#{value.to_date}%'")
    else
      find_by("LOWER(#{attribute}) LIKE ?", "%#{value.downcase}%")
    end
  end
end
