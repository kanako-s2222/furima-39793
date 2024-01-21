FactoryBot.define do
  factory :item do

    association :user

      item_name         {Faker::Commerce.product_name}
      explain           {Faker::Lorem.sentence}
      category_id       {Faker::Number.between(from: 2, to: 11)}
      condition_id      {Faker::Number.between(from: 2, to: 7)}
      delivery_price_id {Faker::Number.between(from: 2, to: 3)}
      place_id          {Faker::Number.between(from: 2, to: 48)}
      delivery_day_id   {Faker::Number.between(from: 2, to: 4)}
      price             {Faker::Number.between(from: 300, to: 9999999)}
      after(:build) do |item|
        item.image.attach(io: File.open('app/assets/images/item-sample.png'), filename: 'image_sample.png', content_type: 'image/png')
      end
    
  end
end
