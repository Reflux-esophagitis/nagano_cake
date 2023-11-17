module Seeds
  class Customers
    def self.create_dev_customer(email, password)
      Customer.create!(
        email: email,
        password: password,
        password_confirmation: password,
        first_name: "太郎",
        last_name: "開発",
        first_name_kana: "タロウ",
        last_name_kana: "カイハツ",
        zip_code: "1234567",
        address: "開発市開発町1-1-1",
        telephone_number: "09012345678",
        is_active: true
      )
      puts "[Seeds] Created Customer for development"
    end

    def self.create_fake_customers(customers_count)
      # 日本のロケールを設定
      Faker::Config.locale = "ja"

      customers_count.times do |i|
        Customer.create!(
          email: Faker::Internet.email,
          password: "password",
          password_confirmation: "password",
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          first_name_kana: "フリガナ",
          last_name_kana: "フリガナ",
          zip_code: Faker::Address.zip_code,
          address: Faker::Address.full_address,
          telephone_number: Faker::PhoneNumber.phone_number,
          is_active: [true, false].sample
        )
        puts "[Seeds] Created Customer with the Faker #{i}"
      end
    end
  end
end
