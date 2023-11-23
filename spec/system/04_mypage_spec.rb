require 'rails_helper'

describe 'マイページのテスト' do
  let(:customer) { create(:customer) }
  before do
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
    visit mypage_customers_path
  end
  context '表示の確認' do
    it '会員情報が画面に表示されていること' do
      expect(page).to have_content customer.last_name
      expect(page).to have_content customer.first_name
      expect(page).to have_content customer.last_name_kana
      expect(page).to have_content customer.first_name_kana
      expect(page).to have_content customer.zip_code
      expect(page).to have_content customer.address
      expect(page).to have_content customer.telephone_number
      expect(page).to have_content customer.email
    end
  #   it 'Editリンクが表示される' do
  #     edit_link = find_all('a')[0].text
  #     click_link edit_link
  #     expect(page).to have_link edit_link, href: mypage_edit_path
		# end
  #   it '配送先リンクが表示される' do
  #     addresses_link = find_all('a')[1]
  #     expect(addresses_link.native.inner_text).to match(addresses)
		# end
		# it '注文履歴一覧リンクが表示される' do
  #     order_link = find_all('a')[2]
  #     expect(order_link.native.inner_text).to match(order)
		# end
  end
  context 'リンクの遷移先の確認' do
    it 'Editの遷移先は編集画面か' do
      edit_link = find_all('a')[5].text
      expect(page).to have_link edit_link, href: mypage_edit_customers_path
    end
    it '配送先リンクの遷移先は配送先一覧画面か' do
      addresses_link = find_all('a')[6].text
      expect(page).to have_link addresses_link, href: addresses_path
		end
		it '注文履歴一覧リンクの遷移先は注文履歴一覧画面か' do
      order_link = find_all('a')[7].text
      expect(page).to have_link order_link, href: orders_path
		end
  end
  describe '会員情報編集画面のテスト' do
    before do
      visit mypage_edit_customers_path
    end
    context '表示の確認' do
      it '編集前の会員情報がフォームに表示(セット)されている' do
        expect(page).to have_field 'customer[last_name]', with: customer.last_name
        expect(page).to have_field 'customer[first_name]', with: customer.first_name
        expect(page).to have_field 'customer[last_name_kana]', with: customer.last_name_kana
        expect(page).to have_field 'customer[first_name_kana]', with: customer.first_name_kana
        expect(page).to have_field 'customer[zip_code]', with: customer.zip_code
        expect(page).to have_field 'customer[address]', with: customer.address
        expect(page).to have_field 'customer[telephone_number]', with: customer.telephone_number
        expect(page).to have_field 'customer[email]', with: customer.email
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '編集内容を保存する'
      end
    end
    context 'リンクの遷移先の確認' do
      it 'confirmの遷移先は詳細画面か' do
        confirm_link = find_all('a')[6]
        expect(page).to have_link confirm_link, href: confirm_customers_path
      end
    end
    context '更新処理に関するテスト' do
      random_last_name = Faker::Lorem.characters(number: 10)
      random_first_name = Faker::Lorem.characters(number: 10)
      random_last_name_kana = Faker::Lorem.characters(number: 10)
      random_first_name_kana = Faker::Lorem.characters(number: 10)
      random_zip_code = rand(100_000_0..999_999_9)
      random_address = Faker::Address.full_address
      random_telephone_number = rand(100_000_000_00..999_999_999_99)
      random_email = Faker::Internet.email
      it '更新に成功しサクセスメッセージが表示されるか' do
        fill_in 'customer[last_name]', with: random_last_name
        fill_in 'customer[first_name]', with: random_first_name
        fill_in 'customer[last_name_kana]', with: random_last_name_kana
        fill_in 'customer[first_name_kana]', with: random_first_name_kana
        fill_in 'customer[zip_code]', with: random_zip_code
        fill_in 'customer[address]', with: random_address
        fill_in 'customer[telephone_number]', with: random_telephone_number
        fill_in 'customer[email]', with: random_email
        click_button '編集内容を保存する'
        expect(page).to have_content '更新しました。'
      end
      it '更新に失敗しエラーメッセージが表示されるか' do
        fill_in 'customer[last_name]', with: ""
        fill_in 'customer[first_name]', with: ""
        fill_in 'customer[last_name_kana]', with: ""
        fill_in 'customer[first_name_kana]', with: ""
        fill_in 'customer[zip_code]', with: ""
        fill_in 'customer[address]', with: ""
        fill_in 'customer[telephone_number]', with: ""
        fill_in 'customer[email]', with: ""
        click_button '編集内容を保存する'
        expect(page).to have_content '入力してください。'
      end
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'customer[last_name]', with: random_last_name
        fill_in 'customer[first_name]', with: random_first_name
        fill_in 'customer[last_name_kana]', with: random_last_name_kana
        fill_in 'customer[first_name_kana]', with: random_first_name_kana
        fill_in 'customer[zip_code]', with: random_zip_code
        fill_in 'customer[address]', with: random_address
        fill_in 'customer[telephone_number]', with: random_telephone_number
        fill_in 'customer[email]', with: random_email
        click_button '編集内容を保存する'
        expect(page).to have_current_path mypage_customers_path
      end
    end
  end
end
