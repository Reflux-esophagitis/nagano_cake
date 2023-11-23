require 'rails_helper'
describe '②登録〜注文' do
  describe '1.トップ画面のテスト' do
    before do
      visit root_path
    end
    context '新規登録画面へのリンクを押下する' do
      it '新規登録画面が表示される' do
        click_link '新規登録'
        expect(current_path).to eq '/customers/sign_up'
      end
    end
    context '新規登録成功のテスト' do
      before do
        visit new_customer_registration_path
        fill_in 'customer[last_name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[first_name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[last_name_kana]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[first_name_kana]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[zip_code]', with: rand(100_000_0..999_999_9)
        fill_in 'customer[address]', with: rand(100_000_0..999_999_9)
        fill_in 'customer[telephone_number]', with: Faker::Address.full_address
        fill_in 'customer[password]', with: 'password'
        fill_in 'customer[password_confirmation]', with: 'password'
      end
      it '必要事項を入力して登録する' do
        expect { click_button '新規登録' }.to change(Customer.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/mypage'
      end
    end
    describe 'ヘッダーのテスト: ログイン後' do
        let(:customer) { create(:customer) }
      before do
        visit new_customer_session_path
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
        visit mypage_customers_path
      end
      context '表示内容の確認' do
        it '表示内容が正しく表示されているか' do
          expect(page).to have_selector '.logo'
          expect(page).to have_content 'マイページ'
          expect(page).to have_content '商品一覧'
          expect(page).to have_content 'カート'
          expect(page).to have_content 'ログアウト'
        end
      end
    end
  end
end
