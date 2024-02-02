FactoryBot.define do
  factory :order_address do
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    place_id { Faker::Number.between(from: 2, to: 48) }
    city     { Faker::Address.city }
    street   { Faker::Address.street_address }
    building { Faker::Address.street_address }
    phone_number { Faker::Number.number(digits: rand(10..11)).to_s }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
