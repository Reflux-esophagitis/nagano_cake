FactoryBot.define do
  factory :customer do
    last_name { Faker::Lorem.characters(number: 10) }
    first_name { Faker::Lorem.characters(number: 10) }
    last_name_kana { Faker::Lorem.characters(number: 10) }
    first_name_kana { Faker::Lorem.characters(number: 10) }
    zip_code { rand(100_000_0..999_999_9) }
    address { Faker::Address.full_address }
    telephone_number { rand(100_000_000_00..999_999_999_99) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    is_active { true }
  end
end
