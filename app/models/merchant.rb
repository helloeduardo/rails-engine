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

  def self.most_items(quantity)
    joins(invoices: [:invoice_items, :transactions])
      .select('merchants.*, SUM(invoice_items.quantity) AS items_sold')
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .order('items_sold DESC')
      .group(:id)
      .limit(quantity)
  end

  def self.total_revenue_between_dates(start, ending)
    joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .where("invoices.created_at >=  '#{start.to_datetime.beginning_of_day}' AND invoices.created_at <=  '#{ending.to_datetime.end_of_day}'")
      .sum('invoice_items.unit_price * invoice_items.quantity')
      .round(2)
  end

  def revenue
    invoices.joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .merge(Invoice.shipped)
      .sum('invoice_items.unit_price * invoice_items.quantity')
      .round(2)
  end
end
