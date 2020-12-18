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
      after :create do |merchant|
        3.times do
          invoice = create(:invoice, merchant: merchant)
          item = create(:item, merchant: merchant)
          item_2 = create(:item, merchant: merchant)

          create(:invoice_item, item: item, invoice: invoice, unit_price: item.unit_price)
          create(:invoice_item, item: item_2, invoice: invoice, unit_price: item_2.unit_price)
          create(:transaction, invoice: invoice)
        end
      end
    end
  end
end
