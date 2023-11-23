FactoryBot.define do
  factory :genre do
    sequence(:name) { |n| ["ケーキ", "焼き菓子", "プリン", "キャンディ"][n % 4] }
  end

  factory :item do
    association :genre, factory: :genre # ジャンルとの関連を定義

    name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 20) }
    non_taxed_price { rand(100..900) }
    is_active { true }

    after(:build) do |item|
      item.image.attach(io: File.open('spec/images/no_image.jpg'), filename: 'no_image.jpg', content_type: 'application/xlsx')
    end
  end
end