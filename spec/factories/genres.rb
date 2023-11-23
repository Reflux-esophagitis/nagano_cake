FactoryBot.define do
  factory :genres do
    names = ['ケーキ', '焼き菓子', 'プリン', 'キャンディ']
    sequence(:name) { |n| names[n % names.length] }
  end
end