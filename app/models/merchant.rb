class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  validates :name, presence: true

  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
      .select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue')
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .order('revenue DESC')
      .group(:id)
      .limit(quantity)
  end

  def revenue
    invoices.joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .sum('invoice_items.unit_price * invoice_items.quantity')
      .round(2)
  end
end
