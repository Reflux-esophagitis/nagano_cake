require 'rails_helper'
describe '①製作〜発送' do
  describe '1.管理者画面のテスト' do
    let(:admin) { create(:admin) }
    before do
      visit new_admin_session_path
    end
    context '管理者ログインのテスト' do
      it 'ログインと遷移先のテスト' do
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        # 現時点'Log in'のため注意
        click_button 'Log in'
        # click_button 'ログイン'
        expect(current_path).to eq '/admin'
      end
    end
    # 現在編集中
    # context '5.商品新規登録画面のテスト' do
    #   let(:genre) { create(:genre) }
    #   before do
    #     visit new_admin_item_path
    #   end
    #   random_name = Faker::Lorem.characters(number: 10)
    #   rondom_introduction = Faker::Lorem.characters(number: 20)
    #   random_non_taxed_price = rand(100..900)
    #   it '商品新規登録と登録後の遷移テスト' do
    #     attach_file('item[image]', Rails.root.join('spec/images/no_image.jpg'))
    #     fill_in 'item[name]', with: random_name
    #     fill_in 'item[introduction]', with: rondom_introduction
    #     select genre.name, from: 'item[genre]'
    #     fill_in 'item[non_taxed_price]', with: random_non_taxed_price
    #     expect { click_button '新規登録' }.to change(Item.all, :count).by(1)
    #     click_button '新規登録'
    #     expect(current_path).to eq '/admin/items/' + Item..last.id.to_s
    #     expect(page).to have_css("img[src*='no_image.jpg']")
    #     expect(page).to have_content item.name
    #     expect(page).to have_content item.introduction
    #     expect(page).to have_content genre.name
    #     expect(page).to have_content item.non_taxed_price
    #     expect(page).to have_content item.is_active
    #   end
    # end
  end
end