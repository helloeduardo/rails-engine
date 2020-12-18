FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }

    trait :with_items do
      transient do
        item_count { 3 }
      end

      after :create do |merchant, evaluator|
        create_list(:item, evaluator.item_count, merchant: merchant)
      end
    end

    trait :with_revenue do
      transient do
        invoice_count { 3 }
        items_per_invoice { 3 }
      end

      after :create do |merchant, evaluator|
        evaluator.invoice_count.times do
          invoice = create(:invoice, merchant: merchant)
          items = create_list(:item, evaluator.items_per_invoice, merchant: merchant)

          items.each do |item|
            create(:invoice_item, item: item, invoice: invoice, unit_price: item.unit_price)
          end

          create(:transaction, invoice: invoice)
        end
      end
    end
  end
end
