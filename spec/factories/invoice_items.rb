FactoryBot.define do
  factory :invoice_item do
    quantity { 3 }
    unit_price { Faker::Commerce.price }
    item
    invoice
  end
end
