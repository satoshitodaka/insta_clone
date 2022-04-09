require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do

  describe 'ユーザー登録' do
    context '入力情報が正しい場合' do
      it 'ユーザー登録ができる' do
        visit new_user_path
        fill_in '名前', with: 'sample user'
        fill_in 'メールアドレス', with: 'sample@instaclone.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button '登録'
        expect(current_path).to eq root_path
        expect(page).to have_content 'ユーザーを作成しました'
      end
    end

    context '入力情報に誤りがある場合' do
      it 'ユーザー登録ができないこと' do
        visit new_user_path
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード確認', with: 'hogehoge'
        click_button '登録'
        # expect(current_path).to eq new_user_path
        expect(page).to have_content '名前を入力してください'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'パスワード確認とパスワードの入力が一致しません'
        expect(page).to have_content 'ユーザーの作成に失敗しました'
      end
    end
  end

  describe 'フォロー機能' do
    let!(:login_user) { create(:user) }
    let!(:other_user) { create(:user) }
    before do
      login_as login_user
    end

    it '他のユーザーをフォローできること' do
      visit posts_path
      expect {
        within "#follow-area-#{other_user.id}" do
          click_link 'フォロー'
          expect(page).to have_content 'アンフォロー'
        end
      }.to change(login_user.following, :count).by(1)
    end

    it '他のユーザーのフォローを外せること' do
      login_user.follow(other_user)
      visit posts_path
      expect {
        within "#follow-area-#{other_user.id}" do
          click_link 'アンフォロー'
          expect(page).to have_content 'フォロー'
        end
      }.to change(login_user.following, :count).by(-1)
    end
  end
end
