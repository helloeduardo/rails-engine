FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Stripe.valid_card }
    credit_card_expiration_date { Faker::Stripe.month + "/" + Faker::Stripe.year[-2..-1] }
    result { "success" }
    invoice
  end
end
