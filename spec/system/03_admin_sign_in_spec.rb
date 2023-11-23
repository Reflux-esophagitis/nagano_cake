require 'rails_helper'
describe '③製作〜発送' do
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
        click_button 'ログイン'
        expect(current_path).to eq '/admin'
      end
    end
  end
end