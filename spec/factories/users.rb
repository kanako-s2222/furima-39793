FactoryBot.define do
  factory :user do
    nickname              {Faker::Lorem.word}
    email                 {Faker::Internet.email}
    password              {'1a' + Faker::Internet.password(min_length: 6, mix_case: true, special_characters: false)}
    password_confirmation {password}
    last_name             {'手塚'}
    first_name            {'忍'}
    last_name_kana        {'テヅカ'}
    first_name_kana       {'シノブ'}
    birthday              {Faker::Date.birthday}
  end
end