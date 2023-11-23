require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
    end
  end
  describe 'ヘッダーのテスト: ログイン前' do
    before do
      visit root_path
    end
    context '表示内容の確認' do
      it '表示内容が正しく表示されているか' do
        expect(page).to have_selector '.logo'
        expect(page).to have_content 'About'
        expect(page).to have_content '商品一覧'
        expect(page).to have_content '新規登録'
        expect(page).to have_content 'ログイン'
      end
    end
    context 'リンクの内容が確認'do
      it 'logo' do
        top_link = find_all('a')[0].text
        click_link top_link
        expect(page).to have_link top_link, href: root_path
      end
      it 'About' do
        about_link = find_all('a')[1].text
        click_link about_link
        expect(page).to have_link about_link, href: about_path
      end
      it '商品一覧' do
        items_link = find_all('a')[2].text
        click_link items_link
        expect(page).to have_link items_link, href: items_path
      end
      it '新規登録' do
        new_customer_registration_link = find_all('a')[3].text
        click_link new_customer_registration_link
        expect(page).to have_link new_customer_registration_link, href: new_customer_registration_path
      end
      it 'ログイン' do
        new_customer_session_link = find_all('a')[4].text
        click_link new_customer_session_link
        expect(page).to have_link new_customer_session_link, href: new_customer_session_path
      end
    end
  end
  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_customer_registration_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_up'
      end
      it '「会員登録」と表示される' do
        expect(page).to have_content '会員登録'
      end
      it 'フォームが表示される' do
        expect(page).to have_field 'customer[last_name]'
        expect(page).to have_field 'customer[first_name]'
        expect(page).to have_field 'customer[last_name_kana]'
        expect(page).to have_field 'customer[first_name_kana]'
        expect(page).to have_field 'customer[email]'
        expect(page).to have_field 'customer[zip_code]'
        expect(page).to have_field 'customer[address]'
        expect(page).to have_field 'customer[telephone_number]'
        expect(page).to have_field 'customer[password]'
        expect(page).to have_field 'customer[password_confirmation]'
      end
      it 'ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end
    context '新規登録成功のテスト' do
      before do
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

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(Customer.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/mypage'
      end
    end
  end
  describe 'ユーザログインのテスト' do
    let(:customer) { create(:customer) }
    before do
      visit new_customer_session_path
    end
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'フォームが表示される' do
        expect(page).to have_field 'customer[email]'
        expect(page).to have_field 'customer[password]'
      end
      it 'ボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end
    context 'ログイン成功のテスト' do
      before do
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
      end
      it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
        expect(current_path).to eq '/'
      end
    end
    context 'ログイン失敗のテスト' do
      before do
        fill_in 'customer[email]', with: ''
        fill_in 'customer[password]', with: ''
        click_button 'ログイン'
      end
      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/customers/sign_in'
      end
    end
  end
  describe 'ヘッダーのテスト: ログイン後' do
    let(:customer) { create(:customer) }
    before do
      visit new_customer_registration_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
    end
  end
end
